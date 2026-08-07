import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  final String title;
  const BarcodeScannerScreen({super.key, this.title = 'Scan Barcode or QR'});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final _mobscannerctrl = MobileScannerController(
    formats: [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.qrCode,
      BarcodeFormat.dataMatrix,
    ],
  );
  bool _scanned = false;
  bool _torch = false;
  final _manualCtrl = TextEditingController();

  @override
  void dispose() {
    _mobscannerctrl.dispose();
    _manualCtrl.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) {
      return;
    }
    final value = capture.barcodes.firstOrNull?.rawValue;
    if (value == null) {
      return;
    }
    setState(() {
      _scanned = true;
    });
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(_torch ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              _mobscannerctrl.toggleTorch();
              setState(() {
                _torch = !_torch;
              });
            },
          ),
          IconButton(
            onPressed: _mobscannerctrl.switchCamera,
            icon: const Icon(Icons.flip_camera_ios_outlined),
          )
        ],
      ),
      body: Column(children: [
        Expanded(
            flex: 4,
            child: Stack(
              children: [
                MobileScanner(
                  controller: _mobscannerctrl,
                  onDetect: _onDetect,
                ),
                Center(
                    child: Container(
                  width: 260,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Point camera at Barcode',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12)))),
                )),
              ],
            )),
        //Manual entry fallback for damaged barcodes
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
                    child: TextField(
                        controller: _manualCtrl,
                        decoration: const InputDecoration(
                            hintText: 'Enter barcode manually...',
                            prefixIcon: Icon(Icons.keyboard)),
                        onSubmitted: (v) {
                          if (v.trim().isNotEmpty)
                            Navigator.pop(context, v.trim());
                        })),
                const SizedBox(width: 8),
                ElevatedButton(
                    onPressed: () {
                      final v = _manualCtrl.text.trim();
                      if (v.isNotEmpty) Navigator.pop(context, v);
                    },
                    child: const Text('Search')),
              ]),
            )),
      ]),
    );
  }
}
