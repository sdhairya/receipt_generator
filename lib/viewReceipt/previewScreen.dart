import 'dart:io';
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:receipt_generator/bluetoothDevicesScreen/bluetoothDevicesScreen.dart';
import 'package:receipt_generator/viewReceipt/viewReceipt.dart';
import 'package:share/share.dart';

class previewScreen extends StatelessWidget {
  // final pw.Document doc;

  final BluetoothDevice device;

  final Uint8List bytes;
  final List<LineText> list;

  const previewScreen(
      {Key? key, required this.device, required this.bytes, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // body: bytes != null ? Image.memory(bytes) : Container(),
          // bottomSheet: ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //       minimumSize: Size(100, 60),
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0),
          //           side: BorderSide(color: Colors.blue))),
          //   child: Text("Print", style: TextStyle(fontSize: 20)),
          //   onPressed: () {
          //     _startPrint(device);
          //   },
          // ),
          appBar: AppBar(
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios_new),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => viewReceipt()));
              },
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                      child: Icon(Icons.print),
                      onTap: () {
                        _startPrint(device);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => bluetoothDevicesScreen(list: list, bytes: bytes,)));                  },
                        // child:
                        //
                      })),
            ],
          ),
          body: Image.memory(bytes)
          // PdfPreview(
          //   build: (format) => doc.save(),
          //   allowSharing: false,
          //   dynamicLayout: true,
          //   allowPrinting: false,
          //   canChangePageFormat: false,
          //   initialPageFormat: PdfPageFormat.roll80,
          //   pdfFileName: "doc.pdf",
          // ),

          ),
    );
  }

  Future<void> _startPrint(BluetoothDevice device) async {
    List<List> queue = [];
    queue.add(list);
    final BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
    if (device != null && device.address != null) {
      await bluetoothPrint.connect(device);

      print(device.name.toString());
      print(device.address.toString());
      bluetoothPrint.state.listen((state) {
        print('cur device status: $state');

        switch (state) {
          case BluetoothPrint.CONNECTED:
            print("Connected");

            break;
          case BluetoothPrint.DISCONNECTED:
            print("not Connected");

            break;
          default:
            print("Other bluetooth device error");
            break;
        }
      });

      Map<String, dynamic> config = Map();
      for (var i in queue) {
        await bluetoothPrint.printReceipt(config, list);
      }
      queue= [];

    }
  }
}
