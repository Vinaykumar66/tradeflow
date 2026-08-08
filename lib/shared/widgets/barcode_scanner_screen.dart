// lib/shared/widgets/barcode_scanner_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/theme/app_colors.dart';

class BarcodeScannerScreen extends ConsumerStatefulWidget {
  final String title;
  const BarcodeScannerScreen({
    super.key,
    this.title = 'Scan Barcode',
  });

  @override
  ConsumerState<BarcodeScannerScreen> createState() =>
      _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  // ── CONTROLLERS ───────────────────────────────────────────────────────────
  late final MobileScannerController _scannerCtrl;
  final _manualCtrl = TextEditingController();
  late final TabController _tabCtrl;

  // ── STATE ─────────────────────────────────────────────────────────────────
  bool _scanActive = true;
  bool _permissionGranted = false;
  bool _permissionChecked = false;
  bool _torchOn = false;
  bool _disposed = false;

  // ── INIT ──────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _tabCtrl = TabController(length: 2, vsync: this);
    _tabCtrl.addListener(_onTabChanged);

    // Create controller once — autoStart false so WE control start timing
    _scannerCtrl = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
      autoStart: false,
    );

    if (kIsWeb) {
      // Web: browser asks for permission automatically when camera starts
      setState(() {
        _permissionGranted = true;
        _permissionChecked = true;
      });
      // Start camera after first frame so widget tree is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_disposed) _startCamera();
      });
    } else {
      _requestPermission();
    }
  }

  // ── deactivate: GUARANTEED to fire on every navigation away ───────────────
  // More reliable than dispose() for stopping camera
  @override
  void deactivate() {
    // Synchronous stop — do not await here
    try {
      _scannerCtrl.stop();
    } catch (_) {}
    super.deactivate();
  }

  @override
  void dispose() {
    _disposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _tabCtrl.removeListener(_onTabChanged);
    _tabCtrl.dispose();
    _manualCtrl.dispose();
    _scannerCtrl.dispose();
    super.dispose();
  }

  // ── APP LIFECYCLE ─────────────────────────────────────────────────────────
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        try {
          _scannerCtrl.stop();
        } catch (_) {}
        break;
      case AppLifecycleState.resumed:
        if (!_disposed && mounted && _tabCtrl.index == 0) {
          _startCamera();
        }
        break;
      default:
        break;
    }
  }

  // ── CAMERA CONTROL ────────────────────────────────────────────────────────
  Future<void> _startCamera() async {
    if (_disposed) return;
    try {
      await _scannerCtrl.start();
      if (!_disposed && mounted) setState(() => _scanActive = true);
    } catch (e) {
      debugPrint('startCamera: $e');
      if (e.toString().contains('controllerInitializing')) {
        await Future.delayed(const Duration(milliseconds: 700));
        if (_disposed || !mounted) return;
        try {
          await _scannerCtrl.start();
          if (!_disposed && mounted) setState(() => _scanActive = true);
        } catch (e2) {
          debugPrint('startCamera retry: $e2');
        }
      }
    }
  }

  Future<void> _stopCamera() async {
    try {
      await _scannerCtrl.stop();
    } catch (e) {
      debugPrint('stopCamera: $e');
    }
  }

  // ── TAB CHANGE ────────────────────────────────────────────────────────────
  void _onTabChanged() {
    if (!_tabCtrl.indexIsChanging) return;
    if (_tabCtrl.index == 1) {
      _stopCamera(); // switching to manual — stop camera
    } else {
      _startCamera(); // switching back to camera — restart
    }
  }

  // ── PERMISSION ────────────────────────────────────────────────────────────
  Future<void> _requestPermission() async {
    var status = await Permission.camera.status;

    if (status.isPermanentlyDenied) {
      if (mounted && !_disposed)
        setState(() {
          _permissionGranted = false;
          _permissionChecked = true;
        });
      return;
    }

    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (mounted && !_disposed) {
      setState(() {
        _permissionGranted = status.isGranted;
        _permissionChecked = true;
      });
      if (status.isGranted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_disposed) _startCamera();
        });
      }
    }
  }

  // ── BARCODE DETECTED ──────────────────────────────────────────────────────
  void _onDetect(BarcodeCapture capture) {
    if (!_scanActive || _disposed) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    if (mounted && !_disposed) setState(() => _scanActive = false);

    final code = barcode!.rawValue!;
    debugPrint('Scanned: $code');
    // Stop before pop
    try {
      _scannerCtrl.stop();
    } catch (_) {}
    if (mounted) context.pop(code);
  }

  // ── MANUAL SUBMIT ─────────────────────────────────────────────────────────
  void _onManualSubmit() {
    final code = _manualCtrl.text.trim();
    if (code.isEmpty) return;
    try {
      _scannerCtrl.stop();
    } catch (_) {}
    if (mounted) context.pop(code);
  }

  // ── CLOSE ─────────────────────────────────────────────────────────────────
  void _onClose() {
    try {
      _scannerCtrl.stop();
    } catch (_) {}
    if (mounted) context.pop(null);
  }

  // ── BUILD ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    // Checking permission
    if (!_permissionChecked) {
      return Scaffold(
          appBar: AppBar(
              title: Text(widget.title),
              leading: IconButton(
                  icon: const Icon(Icons.close), onPressed: _onClose)),
          body: const Center(child: CircularProgressIndicator()));
    }

    // Permission denied
    if (!_permissionGranted) {
      return _PermissionDeniedScreen(
          onRetry: _requestPermission,
          onManualEntry: () {
            if (mounted && !_disposed)
              setState(() {
                _permissionGranted = true;
                _permissionChecked = true;
              });
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _tabCtrl.animateTo(1));
          });
    }

    // Full scanner UI
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _onClose();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading:
              IconButton(icon: const Icon(Icons.close), onPressed: _onClose),
          actions: kIsWeb
              ? []
              : [
                  IconButton(
                      icon: Icon(
                          _torchOn ? Icons.flash_on : Icons.flash_off_outlined),
                      tooltip: _torchOn ? 'Torch off' : 'Torch on',
                      onPressed: () {
                        _scannerCtrl.toggleTorch();
                        setState(() => _torchOn = !_torchOn);
                      }),
                  IconButton(
                      icon: const Icon(Icons.flip_camera_ios_outlined),
                      tooltip: 'Flip camera',
                      onPressed: () => _scannerCtrl.switchCamera()),
                ],
          bottom: TabBar(
            controller: _tabCtrl,
            tabs: const [
              Tab(icon: Icon(Icons.qr_code_scanner), text: 'Camera'),
              Tab(icon: Icon(Icons.keyboard_outlined), text: 'Manual Entry'),
            ],
          ),
        ),

        // ── TabBarView — this is what was WORKING before ─────────────────
        body: TabBarView(
            controller: _tabCtrl,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // ── TAB 0: CAMERA ───────────────────────────────────────────
              Stack(children: [
                MobileScanner(
                  controller: _scannerCtrl,
                  onDetect: _onDetect,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error) => _CameraErrorWidget(
                      error: error,
                      onSwitchToManual: () {
                        _stopCamera();
                        _tabCtrl.animateTo(1);
                      }),
                ),

                // Scan target frame
                Center(
                    child: Container(
                        width: 260,
                        height: 160,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: _scanActive
                                    ? AppColors.primary
                                    : Colors.green,
                                width: 3),
                            borderRadius: BorderRadius.circular(12)),
                        child: Stack(children: [
                          Positioned(
                              top: 0, left: 0, child: _Corner(topLeft: true)),
                          Positioned(
                              top: 0, right: 0, child: _Corner(topRight: true)),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              child: _Corner(bottomLeft: true)),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: _Corner(bottomRight: true)),
                        ]))),

                // Status pill
                Positioned(
                    bottom: 48,
                    left: 0,
                    right: 0,
                    child: Center(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: _scanActive
                                    ? Colors.black54
                                    : Colors.green.shade700,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                                _scanActive
                                    ? 'Point camera at barcode'
                                    : '✓ Barcode detected!',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14))))),

                // Web compatibility note
                if (kIsWeb)
                  Positioned(
                      top: 8,
                      left: 12,
                      right: 12,
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text(
                              'Camera scanning requires Chrome or Edge. '
                              'Use Manual Entry for other browsers.',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 11),
                              textAlign: TextAlign.center))),
              ]),

              // ── TAB 1: MANUAL ENTRY ──────────────────────────────────────
              SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.blue.shade200)),
                            child: const Row(children: [
                              Icon(Icons.info_outline,
                                  color: Colors.blue, size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text(
                                      'Type a barcode or connect a USB / Bluetooth '
                                      'scanner — it auto-fills here.',
                                      style: TextStyle(fontSize: 12))),
                            ])),
                        const SizedBox(height: 28),
                        TextField(
                            controller: _manualCtrl,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _onManualSubmit(),
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'monospace'),
                            decoration: InputDecoration(
                                labelText: 'Barcode Number',
                                hintText: 'e.g. 8901234567890',
                                prefixIcon: const Icon(Icons.qr_code_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () =>
                                        setState(() => _manualCtrl.clear())))),
                        const SizedBox(height: 16),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                                icon: const Icon(Icons.search),
                                label: const Text('Find Product'),
                                onPressed: _onManualSubmit,
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)))),
                        const SizedBox(height: 36),
                        const Text('How to use:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 12),
                        const _HowToRow(
                            icon: Icons.keyboard_outlined,
                            text: 'Type the barcode and tap Find Product'),
                        const _HowToRow(
                            icon: Icons.usb_outlined,
                            text: 'USB barcode scanner — scan auto-fills'),
                        const _HowToRow(
                            icon: Icons.bluetooth_outlined,
                            text: 'Bluetooth scanner — scan auto-fills'),
                        const _HowToRow(
                            icon: Icons.content_paste_outlined,
                            text: 'Paste a barcode from another app'),
                      ])),
            ]),
      ),
    );
  }
}

// ── CORNERS ───────────────────────────────────────────────────────────────────
class _Corner extends StatelessWidget {
  final bool topLeft, topRight, bottomLeft, bottomRight;
  const _Corner({
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(
          painter: _CornerPainter(
              topLeft: topLeft,
              topRight: topRight,
              bottomLeft: bottomLeft,
              bottomRight: bottomRight)));
}

class _CornerPainter extends CustomPainter {
  final bool topLeft, topRight, bottomLeft, bottomRight;
  const _CornerPainter({
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    if (topLeft) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), p);
      canvas.drawLine(Offset.zero, Offset(0, size.height), p);
    }
    if (topRight) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), p);
      canvas.drawLine(
          Offset(size.width, 0), Offset(size.width, size.height), p);
    }
    if (bottomLeft) {
      canvas.drawLine(
          Offset(0, size.height), Offset(size.width, size.height), p);
      canvas.drawLine(Offset.zero, Offset(0, size.height), p);
    }
    if (bottomRight) {
      canvas.drawLine(
          Offset(0, size.height), Offset(size.width, size.height), p);
      canvas.drawLine(
          Offset(size.width, 0), Offset(size.width, size.height), p);
    }
  }

  @override
  bool shouldRepaint(_CornerPainter old) => false;
}

// ── CAMERA ERROR ──────────────────────────────────────────────────────────────
class _CameraErrorWidget extends StatelessWidget {
  final MobileScannerException error;
  final VoidCallback onSwitchToManual;
  const _CameraErrorWidget(
      {required this.error, required this.onSwitchToManual});
  @override
  Widget build(BuildContext context) {
    final msg = switch (error.errorCode) {
      MobileScannerErrorCode.permissionDenied => 'Camera permission denied.\n'
          'Click the camera icon in the browser address bar to allow.',
      MobileScannerErrorCode.unsupported =>
        'Camera not supported in this browser.\n'
            'Use Chrome or Edge, or switch to Manual Entry.',
      _ => 'Camera could not start.\n'
          '${error.errorDetails?.message ?? "Unknown error"}',
    };
    return Container(
        color: Colors.black,
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.videocam_off_outlined,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(msg,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 28),
                  ElevatedButton.icon(
                      icon: const Icon(Icons.keyboard_outlined),
                      label: const Text('Use Manual Entry'),
                      onPressed: onSwitchToManual),
                ]))));
  }
}

// ── PERMISSION DENIED ─────────────────────────────────────────────────────────
class _PermissionDeniedScreen extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onManualEntry;
  const _PermissionDeniedScreen(
      {required this.onRetry, required this.onManualEntry});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: const Text('Scan Barcode'),
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.pop(null))),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.camera_alt_outlined,
                    size: 80, color: Colors.grey),
                const SizedBox(height: 20),
                const Text('Camera Permission Required',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('TradeFlow needs camera access to scan barcodes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Grant Camera Permission'),
                        onPressed: onRetry,
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(vertical: 14)))),
                const SizedBox(height: 12),
                SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        icon: const Icon(Icons.settings_outlined),
                        label: const Text('Open App Settings'),
                        onPressed: () => openAppSettings(),
                        style: OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(vertical: 14)))),
                const SizedBox(height: 12),
                TextButton.icon(
                    icon: const Icon(Icons.keyboard_outlined),
                    label: const Text('Use Manual Entry Instead'),
                    onPressed: onManualEntry),
              ]))));
}

// ── HOW TO ROW ────────────────────────────────────────────────────────────────
class _HowToRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _HowToRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Icon(icon, size: 18, color: Colors.grey.shade500),
        const SizedBox(width: 12),
        Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700))),
      ]));
}

// // lib/shared/widgets/barcode_scanner_screen.dart
// //
// // SINGLE barcode scanner for Android, iOS, and Web.
// // Mobile: camera viewfinder + torch + camera flip
// // Web:    camera viewfinder (Chrome/Edge) + manual entry + HID scanner
// // All platforms have manual entry tab as fallback

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../core/theme/app_colors.dart';
// export '../../../shared/widgets/barcode_scanner_screen.dart';

// class BarcodeScannerScreen extends ConsumerStatefulWidget {
//   final String title;
//   const BarcodeScannerScreen({super.key, this.title = 'Scan Barcode or QR'});

//   @override
//   ConsumerState<BarcodeScannerScreen> createState() =>
//       _BarcodeScannerScreenState();
// }

// class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen>
//     with SingleTickerProviderStateMixin, WidgetsBindingObserver {
//   // ── CONTROLLERS ────────────────────────────────────────────────────────────
//   late final MobileScannerController _scannerCtrl;
//   final TextEditingController _manualCtrl = TextEditingController();
//   late final TabController _tabCtrl;

//   // ── STATE ──────────────────────────────────────────────────────────────────
//   bool _scanActive = true; // prevents double-processing
//   bool _permissionGranted = false; // camera permission status
//   bool _permissionChecked = false; // whether we have checked yet
//   bool _torchOn = false; // torch state for mobile

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
//     // TabController: 2 tabs — Camera | Manual Entry
//     _tabCtrl = TabController(length: 2, vsync: this);
//     _tabCtrl.addListener(_onTabChanged);

//     // MobileScannerController — shared across mobile and web
//     _scannerCtrl = MobileScannerController(
//       detectionSpeed: DetectionSpeed.normal,
//       facing: CameraFacing.back,
//       torchEnabled: false,
//       autoStart: false,
//     );

//     // Web: browser handles permissions — mark as granted immediately
//     // Mobile: request camera permission explicitly
//     if (kIsWeb) {
//       setState(() {
//         _permissionGranted = true;
//         _permissionChecked = true;
//       });
//       // Start camera manually after state is set
//       // WidgetsBinding.instance.addPostFrameCallback((_) => _startCamera());
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _startCamera();
//       });
//     } else {
//       _requestPermission();
//     }
//   }

//   @override
//   void deactivate() {
//     // Stop camera synchronously — do not await
//     // This is the most reliable place to stop on all platforms
//     _scannerCtrl.stop();
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _tabCtrl.removeListener(_onTabChanged);
//     _tabCtrl.dispose();
//     _scannerCtrl.dispose();
//     _manualCtrl.dispose();
//     super.dispose();
//   }

// // Called when app goes to background or screen is covered
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     switch (state) {
//       case AppLifecycleState.paused:
//       case AppLifecycleState.inactive:
//       case AppLifecycleState.hidden:
//         // App going to background — stop camera immediately
//         // _stopCamera();
//         _scannerCtrl.stop();
//         break;
//       case AppLifecycleState.resumed:
//         // App coming back to foreground
//         // Only restart if on camera tab
//         if (mounted && _tabCtrl.index == 0) {
//           _startCamera();
//         }
//         break;
//       // case AppLifecycleState.detached:
//       //   break;
//       default:
//         break;
//     }
//   }

//   // ── PERMISSION (mobile only) ───────────────────────────────────────────────
//   Future<void> _requestPermission() async {
//     final status = await Permission.camera.status;

//     if (status.isGranted) {
//       if (mounted)
//         setState(() {
//           _permissionGranted = true;
//           _permissionChecked = true;
//         });
//       // WidgetsBinding.instance.addPostFrameCallback((_) => _startCamera());
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _startCamera();
//       });
//       return;
//     }
//     if (status.isPermanentlyDenied) {
//       if (mounted)
//         setState(() {
//           _permissionGranted = false;
//           _permissionChecked = true;
//         });
//       return;
//     }
//     final result = await Permission.camera.request();
//     if (mounted)
//       setState(() {
//         _permissionGranted = result.isGranted;
//         _permissionChecked = true;
//       });
//     if (result.isGranted) {
//       // WidgetsBinding.instance.addPostFrameCallback((_) => _startCamera());
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) _startCamera();
//       });
//     }
//   }

//   // ── TAB CHANGE ─────────────────────────────────────────────────────────────
//   void _onTabChanged() {
//     if (!_tabCtrl.indexIsChanging) return;
//     if (_tabCtrl.index == 1) {
//       // Switched to Manual Entry — pause camera to save battery
//       // _scannerCtrl.stop();
//       _stopCamera();
//     } else {
//       // Switched back to Camera — resume scanning
//       // _scannerCtrl.start();
//       _startCamera();
//       setState(() => _scanActive = true);
//     }
//   }

//   Future<void> _startCamera() async {
//     try {
//       await _scannerCtrl.start();
//       if (mounted) setState(() => _scanActive = true);
//     } catch (e) {
//       debugPrint('Camera start: $e');
//       // Retry once after short delay if still initializing
//       if (e.toString().contains('controllerInitializing')) {
//         await Future.delayed(const Duration(milliseconds: 600));
//         try {
//           if (mounted) await _scannerCtrl.start();
//           if (mounted) setState(() => _scanActive = true);
//         } catch (e2) {
//           debugPrint('Camera start retry failed: $e2');
//         }
//       }
//     }
//   }

//   Future<void> _stopCamera() async {
//     try {
//       await _scannerCtrl.stop();
//     } catch (e) {
//       debugPrint('Camera stop: $e');
//       // Ignore stop errors — camera may already be stopped
//     }
//   }

// // // Safe stop — handles any controller state
// //   Future<void> _stopCamera() async {
// //     try {
// //       await _scannerCtrl.stop();
// //     } catch (e) {
// //       debugPrint('Camera stop ignored: $e');
// //     }
// //   }

// // // Safe start — waits for controller to be ready
// //   Future<void> _startCamera() async {
// //     try {
// //       await _scannerCtrl.start();
// //       if (mounted) setState(() => _scanActive = true);
// //     } catch (e) {
// //       debugPrint('Camera start error: $e');
// //       // If still initializing wait briefly and retry once
// //       await Future.delayed(const Duration(milliseconds: 500));
// //       try {
// //         await _scannerCtrl.start();
// //         if (mounted) setState(() => _scanActive = true);
// //       } catch (e2) {
// //         debugPrint('Camera start retry failed: $e2');
// //       }
// //     }
// //   }

//   // ── BARCODE DETECTED (camera) ──────────────────────────────────────────────
//   void _onDetect(BarcodeCapture capture) {
//     if (!_scanActive) return;
//     final barcode = capture.barcodes.firstOrNull;
//     if (barcode?.rawValue == null) return;

//     setState(() => _scanActive = false);
//     final code = barcode!.rawValue!;
//     debugPrint('Barcode scanned: $code');

//     // Return barcode to the calling screen
//     if (mounted) context.pop(code);
//   }

//   // ── MANUAL SUBMIT (keyboard / HID scanner) ─────────────────────────────────
//   void _onManualSubmit() {
//     final code = _manualCtrl.text.trim();
//     if (code.isEmpty) return;
//     debugPrint('Manual barcode: $code');
//     if (mounted) context.pop(code);
//   }

//   // ── TORCH TOGGLE (mobile only) ────────────────────────────────────────────
//   void _toggleTorch() {
//     _scannerCtrl.toggleTorch();
//     setState(() => _torchOn = !_torchOn);
//   }

//   // ── BUILD ──────────────────────────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     // While checking permission — show spinner
//     if (!_permissionChecked) {
//       return Scaffold(
//           appBar: AppBar(
//               title: const Text('Scan Barcode'),
//               leading: IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => context.pop(null))),
//           body: const Center(child: CircularProgressIndicator()));
//     }

//     // Permission denied on mobile — show permission screen
//     if (!_permissionGranted) {
//       return _PermissionDeniedScreen(
//         onRetry: _requestPermission,
//         onManualEntry: () {
//           setState(() {
//             _permissionGranted = true; // show tabs
//             _permissionChecked = true;
//           });
//           // Switch to manual entry tab
//           WidgetsBinding.instance
//               .addPostFrameCallback((_) => _tabCtrl.animateTo(1));
//         },
//       );
//     }

//     // Permission granted — show full scanner
//     return PopScope(
//       onPopInvokedWithResult: (didPop, result) {
//         // Stop camera immediately when user taps back or close button
//         _scannerCtrl.stop();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Scan Barcode'),
//           leading: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () {
//                 _scannerCtrl.stop();
//                 context.pop(null);
//               }),
//           // Mobile-only actions: torch and camera flip
//           actions: kIsWeb
//               ? []
//               : [
//                   IconButton(
//                       icon: Icon(
//                           _torchOn ? Icons.flash_on : Icons.flash_off_outlined),
//                       tooltip: _torchOn ? 'Turn off torch' : 'Turn on torch',
//                       onPressed: _toggleTorch),
//                   IconButton(
//                       icon: const Icon(Icons.flip_camera_ios_outlined),
//                       tooltip: 'Flip camera',
//                       onPressed: () => _scannerCtrl.switchCamera()),
//                 ],
//           bottom: TabBar(
//             controller: _tabCtrl,
//             tabs: const [
//               Tab(icon: Icon(Icons.qr_code_scanner), text: 'Camera'),
//               Tab(icon: Icon(Icons.keyboard_outlined), text: 'Manual Entry'),
//             ],
//           ),
//         ),

//         // IndexedStack keeps both tabs alive
//         // Camera tab stays initialised when switching to manual
//         body: TabBarView(
//             controller: _tabCtrl,
//             // Disable swipe on camera tab — accidental swipe stops scanner
//             physics: const NeverScrollableScrollPhysics(),
//             children: [
//               // ── TAB 0: CAMERA SCANNER ──────────────────────────────────────
//               Stack(children: [
//                 // Camera viewfinder — works on mobile and web (Chrome/Edge)
//                 MobileScanner(
//                   controller: _scannerCtrl,
//                   onDetect: _onDetect,
//                   // No autoStart needed — controller manages itself
//                   errorBuilder: (context, error) => _CameraErrorWidget(
//                       error: error,
//                       onSwitchToManual: () => _tabCtrl.animateTo(1)),
//                 ),

//                 // Scan target rectangle overlay
//                 Center(
//                     child: Container(
//                         width: 260,
//                         height: 160,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: _scanActive
//                                     ? AppColors.primary
//                                     : Colors.green,
//                                 width: 3),
//                             borderRadius: BorderRadius.circular(12),
//                             // Semi-transparent corners for visual guide
//                             color: Colors.transparent),
//                         // Corner markers
//                         child: Stack(children: [
//                           // Top left
//                           Positioned(
//                               top: 0, left: 0, child: _Corner(topLeft: true)),
//                           // Top right
//                           Positioned(
//                               top: 0, right: 0, child: _Corner(topRight: true)),
//                           // Bottom left
//                           Positioned(
//                               bottom: 0,
//                               left: 0,
//                               child: _Corner(bottomLeft: true)),
//                           // Bottom right
//                           Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: _Corner(bottomRight: true)),
//                         ]))),

//                 // Status label
//                 Positioned(
//                     bottom: 48,
//                     left: 0,
//                     right: 0,
//                     child: Center(
//                         child: AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 10),
//                             decoration: BoxDecoration(
//                                 color: _scanActive
//                                     ? Colors.black54
//                                     : Colors.green.shade700,
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: Text(
//                                 _scanActive
//                                     ? 'Point camera at barcode'
//                                     : '✓ Barcode detected!',
//                                 style: const TextStyle(
//                                     color: Colors.white, fontSize: 14))))),

//                 // Web browser compatibility note
//                 if (kIsWeb)
//                   Positioned(
//                       top: 8,
//                       left: 12,
//                       right: 12,
//                       child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                               color: Colors.black54,
//                               borderRadius: BorderRadius.circular(8)),
//                           child: const Text(
//                               'Camera scanning requires Chrome or Edge. '
//                               'For other browsers use Manual Entry tab.',
//                               style: TextStyle(
//                                   color: Colors.white70, fontSize: 11),
//                               textAlign: TextAlign.center))),
//               ]),

//               // ── TAB 1: MANUAL ENTRY / HID SCANNER ─────────────────────────
//               SingleChildScrollView(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 16),

//                         // Info box
//                         Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                                 color: Colors.blue.shade50,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border:
//                                     Border.all(color: Colors.blue.shade200)),
//                             child: const Row(children: [
//                               Icon(Icons.info_outline,
//                                   color: Colors.blue, size: 18),
//                               SizedBox(width: 8),
//                               Expanded(
//                                   child: Text(
//                                       'Type a barcode manually or connect a USB / '
//                                       'Bluetooth barcode scanner — it will auto-fill here.',
//                                       style: TextStyle(fontSize: 12))),
//                             ])),

//                         const SizedBox(height: 28),

//                         // Barcode input
//                         TextField(
//                             controller: _manualCtrl,
//                             autofocus: true, // HID scanner types here directly
//                             keyboardType: TextInputType.text,
//                             textInputAction: TextInputAction.done,
//                             onSubmitted: (_) =>
//                                 _onManualSubmit(), // HID sends Enter
//                             style: const TextStyle(
//                                 fontSize: 18, fontFamily: 'monospace'),
//                             decoration: InputDecoration(
//                                 labelText: 'Barcode Number',
//                                 hintText: 'e.g. 8901234567890',
//                                 prefixIcon: const Icon(Icons.qr_code_outlined),
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 suffixIcon: IconButton(
//                                     icon: const Icon(Icons.clear),
//                                     onPressed: () {
//                                       _manualCtrl.clear();
//                                       setState(() {});
//                                     }))),

//                         const SizedBox(height: 16),

//                         // Find Product button
//                         SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton.icon(
//                                 icon: const Icon(Icons.search),
//                                 label: const Text('Find Product'),
//                                 onPressed: _onManualSubmit,
//                                 style: ElevatedButton.styleFrom(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 14),
//                                     textStyle: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold)))),

//                         const SizedBox(height: 36),

//                         // How to use section
//                         const Text('How to use:',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 14)),
//                         const SizedBox(height: 12),
//                         const _HowToRow(
//                             icon: Icons.keyboard_outlined,
//                             text:
//                                 'Type the barcode number and tap Find Product'),
//                         const _HowToRow(
//                             icon: Icons.usb_outlined,
//                             text:
//                                 'Connect a USB barcode scanner — scan auto-fills the field'),
//                         const _HowToRow(
//                             icon: Icons.bluetooth_outlined,
//                             text:
//                                 'Pair a Bluetooth scanner — scan auto-fills the field'),
//                         const _HowToRow(
//                             icon: Icons.content_paste_outlined,
//                             text: 'Paste a barcode copied from another app'),
//                       ])),
//             ]),
//       ),
//     );
//   }
// }

// // ── CORNER MARKER WIDGET ──────────────────────────────────────────────────────
// // Small L-shaped corner marks on the scan target rectangle
// class _Corner extends StatelessWidget {
//   final bool topLeft, topRight, bottomLeft, bottomRight;
//   const _Corner({
//     this.topLeft = false,
//     this.topRight = false,
//     this.bottomLeft = false,
//     this.bottomRight = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: 20,
//         height: 20,
//         child: CustomPaint(
//             painter: _CornerPainter(
//                 topLeft: topLeft,
//                 topRight: topRight,
//                 bottomLeft: bottomLeft,
//                 bottomRight: bottomRight)));
//   }
// }

// class _CornerPainter extends CustomPainter {
//   final bool topLeft, topRight, bottomLeft, bottomRight;
//   const _CornerPainter({
//     this.topLeft = false,
//     this.topRight = false,
//     this.bottomLeft = false,
//     this.bottomRight = false,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     if (topLeft) {
//       canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
//       canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
//     }
//     if (topRight) {
//       canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
//       canvas.drawLine(
//           Offset(size.width, 0), Offset(size.width, size.height), paint);
//     }
//     if (bottomLeft) {
//       canvas.drawLine(
//           Offset(0, size.height), Offset(size.width, size.height), paint);
//       canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
//     }
//     if (bottomRight) {
//       canvas.drawLine(
//           Offset(0, size.height), Offset(size.width, size.height), paint);
//       canvas.drawLine(
//           Offset(size.width, 0), Offset(size.width, size.height), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(_CornerPainter old) => false;
// }

// // ── CAMERA ERROR WIDGET ───────────────────────────────────────────────────────
// class _CameraErrorWidget extends StatelessWidget {
//   final MobileScannerException error;
//   final VoidCallback onSwitchToManual;
//   const _CameraErrorWidget(
//       {required this.error, required this.onSwitchToManual});

//   @override
//   Widget build(BuildContext context) {
//     final message = switch (error.errorCode) {
//       MobileScannerErrorCode.permissionDenied => 'Camera permission denied.\n'
//           'Tap the camera icon in your browser address bar '
//           'to allow access, then try again.',
//       MobileScannerErrorCode.unsupported =>
//         'Camera not supported in this browser.\n'
//             'Please use Chrome or Edge for camera scanning.',
//       _ => 'Camera could not start.\n'
//           '${error.errorDetails?.message ?? 'Unknown error'}',
//     };

//     return Container(
//         color: Colors.black,
//         child: Center(
//             child: Padding(
//                 padding: const EdgeInsets.all(32),
//                 child: Column(mainAxisSize: MainAxisSize.min, children: [
//                   const Icon(Icons.videocam_off_outlined,
//                       size: 64, color: Colors.grey),
//                   const SizedBox(height: 16),
//                   Text(message,
//                       style: const TextStyle(color: Colors.white, fontSize: 14),
//                       textAlign: TextAlign.center),
//                   const SizedBox(height: 28),
//                   ElevatedButton.icon(
//                       icon: const Icon(Icons.keyboard_outlined),
//                       label: const Text('Use Manual Entry'),
//                       onPressed: onSwitchToManual),
//                 ]))));
//   }
// }

// // ── PERMISSION DENIED SCREEN ──────────────────────────────────────────────────
// class _PermissionDeniedScreen extends StatelessWidget {
//   final VoidCallback onRetry;
//   final VoidCallback onManualEntry;
//   const _PermissionDeniedScreen(
//       {required this.onRetry, required this.onManualEntry});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: const Text('Scan Barcode'),
//             leading: IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () => context.pop(null))),
//         body: Center(
//             child: Padding(
//                 padding: const EdgeInsets.all(32),
//                 child: Column(mainAxisSize: MainAxisSize.min, children: [
//                   const Icon(Icons.camera_alt_outlined,
//                       size: 80, color: Colors.grey),
//                   const SizedBox(height: 20),
//                   const Text('Camera Permission Required',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 12),
//                   const Text(
//                       'TradeFlow needs camera access to scan product barcodes.\n'
//                       'Please allow camera permission to continue.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.grey, height: 1.5)),
//                   const SizedBox(height: 32),
//                   SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                           icon: const Icon(Icons.camera_alt),
//                           label: const Text('Grant Camera Permission'),
//                           onPressed: onRetry,
//                           style: ElevatedButton.styleFrom(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 14)))),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                       width: double.infinity,
//                       child: OutlinedButton.icon(
//                           icon: const Icon(Icons.settings_outlined),
//                           label: const Text('Open App Settings'),
//                           onPressed: () => openAppSettings(),
//                           style: OutlinedButton.styleFrom(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 14)))),
//                   const SizedBox(height: 12),
//                   TextButton.icon(
//                       icon: const Icon(Icons.keyboard_outlined),
//                       label: const Text('Use Manual Entry Instead'),
//                       onPressed: onManualEntry),
//                 ]))));
//   }
// }

// // ── HOW TO ROW ────────────────────────────────────────────────────────────────
// class _HowToRow extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   const _HowToRow({required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) => Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(children: [
//         Icon(icon, size: 18, color: Colors.grey.shade500),
//         const SizedBox(width: 12),
//         Expanded(
//             child: Text(text,
//                 style: TextStyle(fontSize: 13, color: Colors.grey.shade700))),
//       ]));
// }

// // import 'package:flutter/material.dart';
// // import 'package:mobile_scanner/mobile_scanner.dart';

// // class BarcodeScannerScreen extends StatefulWidget {
// //   final String title;
// //   const BarcodeScannerScreen({super.key, this.title = 'Scan Barcode or QR'});

// //   @override
// //   State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
// // }

// // class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
// //   final _mobscannerctrl = MobileScannerController(
// //     formats: [
// //       BarcodeFormat.ean13,
// //       BarcodeFormat.ean8,
// //       BarcodeFormat.upcA,
// //       BarcodeFormat.upcE,
// //       BarcodeFormat.code128,
// //       BarcodeFormat.code39,
// //       BarcodeFormat.qrCode,
// //       BarcodeFormat.dataMatrix,
// //     ],
// //   );
// //   bool _scanned = false;
// //   bool _torch = false;
// //   final _manualCtrl = TextEditingController();

// //   @override
// //   void dispose() {
// //     _mobscannerctrl.dispose();
// //     _manualCtrl.dispose();
// //     super.dispose();
// //   }

// //   void _onDetect(BarcodeCapture capture) {
// //     if (_scanned) {
// //       return;
// //     }
// //     final value = capture.barcodes.firstOrNull?.rawValue;
// //     if (value == null) {
// //       return;
// //     }
// //     setState(() {
// //       _scanned = true;
// //     });
// //     Navigator.pop(context, value);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //         actions: [
// //           IconButton(
// //             icon: Icon(_torch ? Icons.flash_on : Icons.flash_off),
// //             onPressed: () {
// //               _mobscannerctrl.toggleTorch();
// //               setState(() {
// //                 _torch = !_torch;
// //               });
// //             },
// //           ),
// //           IconButton(
// //             onPressed: _mobscannerctrl.switchCamera,
// //             icon: const Icon(Icons.flip_camera_ios_outlined),
// //           )
// //         ],
// //       ),
// //       body: Column(children: [
// //         Expanded(
// //             flex: 4,
// //             child: Stack(
// //               children: [
// //                 MobileScanner(
// //                   controller: _mobscannerctrl,
// //                   onDetect: _onDetect,
// //                 ),
// //                 Center(
// //                     child: Container(
// //                   width: 260,
// //                   height: 200,
// //                   decoration: BoxDecoration(
// //                       border: Border.all(color: Colors.green, width: 2),
// //                       borderRadius: BorderRadius.circular(8)),
// //                   child: const Align(
// //                       alignment: Alignment.bottomCenter,
// //                       child: Padding(
// //                           padding: EdgeInsets.all(8),
// //                           child: Text('Point camera at Barcode',
// //                               style: TextStyle(
// //                                   color: Colors.white70, fontSize: 12)))),
// //                 )),
// //               ],
// //             )),
// //         //Manual entry fallback for damaged barcodes
// //         Expanded(
// //             flex: 1,
// //             child: Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Row(children: [
// //                 Expanded(
// //                     child: TextField(
// //                         controller: _manualCtrl,
// //                         decoration: const InputDecoration(
// //                             hintText: 'Enter barcode manually...',
// //                             prefixIcon: Icon(Icons.keyboard)),
// //                         onSubmitted: (v) {
// //                           if (v.trim().isNotEmpty)
// //                             Navigator.pop(context, v.trim());
// //                         })),
// //                 const SizedBox(width: 8),
// //                 ElevatedButton(
// //                     onPressed: () {
// //                       final v = _manualCtrl.text.trim();
// //                       if (v.isNotEmpty) Navigator.pop(context, v);
// //                     },
// //                     child: const Text('Search')),
// //               ]),
// //             )),
// //       ]),
// //     );
// //   }
// // }
