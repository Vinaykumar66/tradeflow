import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kPrefKeyPairedPrinter = 'thermal_printer_mac_address';

class ThermalPrinterPairingScreen extends StatefulWidget {
  const ThermalPrinterPairingScreen({super.key});

  @override
  State<ThermalPrinterPairingScreen> createState() =>
      _ThermalPrinterPairingScreenState();
}

class _ThermalPrinterPairingScreenState
    extends State<ThermalPrinterPairingScreen> {
  List<BluetoothInfo> _devices = [];
  String? _savedMac;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final paired = await PrintBluetoothThermal.pairedBluetooths;
    setState(() {
      _devices = paired;
      _savedMac = prefs.getString(_kPrefKeyPairedPrinter);
      _loading = false;
    });
  }

  Future<void> _select(BluetoothInfo device) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrefKeyPairedPrinter, device.macAdress);
    setState(() {
      _savedMac = device.macAdress;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${device.name} saved as your printer.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Thermal Printer'), actions: [
          IconButton(onPressed: _load, icon: const Icon(Icons.refresh)),
        ]),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : _devices.isEmpty
                ? Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.bluetooth_disabled,
                        size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    const Text('No paired Bluetooth printers found.'),
                    const SizedBox(height: 4),
                    const Text(
                        'Pair the printer in your phone Bluetooth settings first, then tap Refresh.')
                  ]))
                : ListView.builder(
                    itemCount: _devices.length,
                    itemBuilder: (_, i) {
                      final d = _devices[i];
                      final selected = d.macAdress == _savedMac;
                      return ListTile(
                          leading: Icon(
                              selected
                                  ? Icons.check_circle
                                  : Icons.print_outlined,
                              color: selected ? Colors.green : Colors.grey),
                          title: Text(d.name),
                          subtitle: Text(d.macAdress),
                          onTap: () => _select(d));
                    }));
  }
}
