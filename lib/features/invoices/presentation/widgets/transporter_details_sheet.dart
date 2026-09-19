import 'package:flutter/material.dart';

class TransporterDetails {
  final String transporterName, vehicleNumber, transportMode;
  final String? transporterGstin;
  final int distanceKm;
  const TransporterDetails({
    required this.transporterName,
    required this.vehicleNumber,
    required this.transportMode,
    required this.distanceKm,
    this.transporterGstin,
  });
}

class TransporterDetailsSheet {
  static Future<TransporterDetails?> show(BuildContext context) {
    final nameCtrl = TextEditingController();
    final gstinCtrl = TextEditingController();
    final vehicleCtrl = TextEditingController();
    final distanceCtrl = TextEditingController();
    var mode = 'road';

    return showModalBottomSheet<TransporterDetails>(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Transporter Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    TextField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Transporter Name')),
                    TextField(
                        controller: gstinCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Transporter GSTIN(optional)')),
                    TextField(
                        controller: vehicleCtrl,
                        textCapitalization: TextCapitalization.characters,
                        decoration:
                            const InputDecoration(labelText: 'Vehicle Number')),
                    TextField(
                        controller: distanceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Approx. Distance (km)')),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(
                            ctx,
                            TransporterDetails(
                                transporterName: nameCtrl.text.trim(),
                                transporterGstin: gstinCtrl.text.trim().isEmpty
                                    ? null
                                    : gstinCtrl.text.trim(),
                                vehicleNumber: vehicleCtrl.text.trim(),
                                transportMode: mode,
                                distanceKm:
                                    int.tryParse(distanceCtrl.text) ?? 0)),
                        child: const Text('Continue')),
                  ],
                ),
              ),
            ));
  }
}
