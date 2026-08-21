import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../shared/models/product.dart';

class _ScanEntry {
  final Product product;
  int count;
  _ScanEntry(this.product, this.count);
}

class InvoiceScanModeScreen extends ConsumerStatefulWidget {
  final String bizId;
  final String sym;
  final bool lakh;
  // Called once per successful scan — parent owns merging this into
  // the real invoice (increment existing line vs add new line).
  final void Function(Product) onProductScanned;

  const InvoiceScanModeScreen({
    super.key,
    required this.bizId,
    required this.sym,
    required this.lakh,
    required this.onProductScanned,
  });

  @override
  ConsumerState<InvoiceScanModeScreen> createState() =>
      _InvoiceScanModeScreenState();
}

class _InvoiceScanModeScreenState extends ConsumerState<InvoiceScanModeScreen>
    with WidgetsBindingObserver {
  // Same hard-won camera lifecycle pattern as BarcodeScannerScreen —
  // reused deliberately rather than re-derived.
  late final MobileScannerController _scannerCtrl;
  bool _permissionGranted = false;
  bool _permissionChecked = false;
  bool _disposed = false;
  int _pendingLookups = 0;
  bool _closing = false; // prevents double-pop if Done is tapped twice

  final List<_ScanEntry> _entries = [];
  int _sessionCount = 0;
  int _sessionTotal = 0; // smallest currency unit

  // Debounce — MobileScanner fires onDetect repeatedly while a code
  // stays in frame. Without this, one scan adds the item 10+ times.
  static const _kRescanCooldown = Duration(seconds: 2);
  String? _lastCode;
  DateTime? _lastCodeAt;

  // Brief on-camera feedback banner
  String? _banner;
  bool _bannerIsError = false;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _scannerCtrl = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
      autoStart: false,
    );

    _requestPermission();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.camera.status;
    if (status.isPermanentlyDenied) {
      if (mounted)
        setState(() {
          _permissionGranted = false;
          _permissionChecked = true;
        });
      return;
    }
    final result =
        status.isGranted ? status : await Permission.camera.request();
    if (!mounted) return;
    setState(() {
      _permissionGranted = result.isGranted;
      _permissionChecked = true;
    });
    if (result.isGranted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startCamera());
    }
  }

  Future<void> _startCamera() async {
    if (_disposed) return;
    try {
      await _scannerCtrl.start();
    } catch (e) {
      if (e.toString().contains('controllerInitializing')) {
        await Future.delayed(const Duration(milliseconds: 700));
        if (!_disposed) await _scannerCtrl.start();
      }
    }
  }

  @override
  void deactivate() {
    // Guaranteed to fire on any navigation away, including back gesture
    try {
      _scannerCtrl.stop();
    } catch (_) {}
    super.deactivate();
  }

  @override
  void dispose() {
    _disposed = true;
    _bannerTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _scannerCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      try {
        _scannerCtrl.stop();
      } catch (_) {}
    } else if (state == AppLifecycleState.resumed && !_disposed) {
      _startCamera();
    }
  }

  // ── SCAN HANDLING — never stops the camera, never pops ──────────────────
  Future<void> _onDetect(BarcodeCapture capture) async {
    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null) return;

    final now = DateTime.now();
    if (code == _lastCode &&
        _lastCodeAt != null &&
        now.difference(_lastCodeAt!) < _kRescanCooldown) {
      return; // same code still in frame — ignore
    }
    _lastCode = code;
    _lastCodeAt = now;

    _pendingLookups++;
    try {
      final product = await ref
          .read(productRepositoryProvider)
          .getProductByBarcode(widget.bizId, code);

      if (!mounted) return;

      if (product == null) {
        _showBanner('No product for "$code"', isError: true);
        return;
      }

      // Tell the parent screen to add/increment the real invoice line
      widget.onProductScanned(product);

      // Update this screen's own preview list
      setState(() {
        final existing = _entries.indexWhere((e) => e.product.id == product.id);
        if (existing >= 0) {
          final e = _entries.removeAt(existing);
          e.count++;
          _entries.insert(0, e);
        } else {
          _entries.insert(0, _ScanEntry(product, 1));
        }
        _sessionCount++;
        _sessionTotal += product.sellingPrice;
      });

      _showBanner('Added: ${product.name}', isError: false);
    } finally {
      _pendingLookups--;
    }
  }

  Future<void> _finishScanning() async {
    if (_closing) return;
    _closing = true;
    while (_pendingLookups > 0) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (!mounted) return;
    _scannerCtrl.stop();
    Navigator.of(context).pop();
  }

  void _showBanner(String text, {required bool isError}) {
    _bannerTimer?.cancel();
    setState(() {
      _banner = text;
      _bannerIsError = isError;
    });
    _bannerTimer = Timer(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _banner = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionChecked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!_permissionGranted) {
      return Scaffold(
          appBar: AppBar(title: const Text('Scan Items')),
          body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.camera_alt_outlined,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('Camera permission is needed to scan items.',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: _requestPermission,
                        child: const Text('Grant Permission')),
                  ]))));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _finishScanning();
          _scannerCtrl.stop();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scan Items ($_sessionCount)'),
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _finishScanning;
                _scannerCtrl.stop();
                Navigator.of(context).pop();
              }),
          actions: [
            _pendingLookups > 0
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white)))
                : TextButton(
                    onPressed: () {
                      _finishScanning;
                      _scannerCtrl.stop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Done',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          final scannerPane = _scannerPane();
          final itemsPane = _itemsPane();

          return isWide
              ? Row(children: [
                  Expanded(child: scannerPane),
                  const VerticalDivider(width: 1),
                  Expanded(child: itemsPane),
                ])
              : Column(children: [
                  Expanded(child: scannerPane),
                  const Divider(height: 1),
                  Expanded(child: itemsPane),
                ]);
        }),
      ),
    );
  }

  Widget _scannerPane() => Stack(children: [
        MobileScanner(
            controller: _scannerCtrl, onDetect: _onDetect, fit: BoxFit.cover),
        Center(
            child: Container(
                width: 220,
                height: 140,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 3),
                    borderRadius: BorderRadius.circular(10)))),
        if (_banner != null)
          Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: _bannerIsError
                          ? Colors.red.shade700
                          : Colors.green.shade700,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(_banner!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)))),
      ]);

  Widget _itemsPane() => Column(children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: AppColors.surfaceVariant,
            child: Row(children: [
              Text('$_sessionCount scanned',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(
                  CurrencyFormatter.format(_sessionTotal,
                      sym: widget.sym, lakh: widget.lakh),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ])),
        Expanded(
            child: _entries.isEmpty
                ? const Center(
                    child: Text('Scanned items appear here',
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: _entries.length,
                    itemBuilder: (_, i) {
                      final e = _entries[i];
                      return ListTile(
                          dense: true,
                          title: Text(e.product.name,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: Text('×${e.count}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)));
                    })),
      ]);
}
