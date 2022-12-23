import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

import '../viewReceipt/previewScreen.dart';

class bluetoothDevicesScreen extends StatefulWidget {
  final List<LineText> list;
  final Uint8List bytes;
  const bluetoothDevicesScreen({Key? key, required this.list, required this.bytes}) : super(key: key);

  @override
  State<bluetoothDevicesScreen> createState() => _bluetoothDevicesScreenState();
}

class _bluetoothDevicesScreenState extends State<bluetoothDevicesScreen> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _deviceMsg = "";

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter() });
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 100));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if (!mounted) return;
      setState(() {
        _devices = val;
      });
      if (_devices.isEmpty)
        setState(() {
          _deviceMsg = "No Devices";
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new),onPressed: () {
            bluetoothPrint.stopScan();
            Navigator.pop(context, true);
          },),
          title: Text("Select Printer"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: ()  {
                    bluetoothPrint.stopScan();
                    initPrinter();
                  },
                  child: Icon(Icons.refresh),
                ))
          ],
        ),
        body: _devices.isEmpty
            ? Center(
          child: const CircularProgressIndicator(
            color: Colors.blue,
            backgroundColor: Colors.transparent,
          ),
        )
            :
        ListView.builder(
          itemCount: _devices.length,

          itemBuilder: (c, i) {
            return ListTile(
              leading: Icon(Icons.print),
              title: Text(_devices[i].name.toString()),
              subtitle: Text(_devices[i].address.toString()),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => previewScreen(device: _devices[i], bytes: widget.bytes, list: widget.list,)));
                // _startPrint(_devices[i]);
              },
            );
          },
        ));
  }

}
