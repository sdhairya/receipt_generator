
import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:receipt_generator/bluetoothDevicesScreen/bluetoothDevicesScreen.dart';
import 'package:receipt_generator/components.dart';
import 'package:receipt_generator/list.dart';
import 'package:pdf/pdf.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:receipt_generator/supabasehandler.dart';
import 'package:receipt_generator/utils.dart';

import 'package:receipt_generator/viewReceipt/previewScreen.dart';
import 'package:receipt_generator/viewReceipt/printable_data.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:receipt_generator/viewReceipt/receipt.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  // List<receiptData> receiptdata = [];
  List<resturants> resturantsdata = [];


  @override
  void initState() {
    // getData();
    // receiptdata.clear();
    resturantsdata.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey globalKey = GlobalKey();

    DateTime today = DateTime.now();
    String date = "${today.day}-${today.month}-${today.year}";
    String time = "${today.hour}:${today.minute}";

    if (resturantsdata.isEmpty) {
      // SupaBaseHandler().readreceiptData().then((value) {
      //   setState(() {
      //     receiptdata = value;
      //   });
      // });

      SupaBaseHandler().readresturantData().then((value) {
        setState(() {
          resturantsdata = value;
        });
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: components()
              .text("Receipt Invoice", FontWeight.bold, Colors.black, 20),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () async {


                    setState(() {
                    });
                    // printDoc(date, time, bytes);

                  },
                  child: Icon(Icons.save),
                ))
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: Column(
                children: [
                  // buildListWithScroll(receiptdata)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }



  Widget buildListWithScroll(List<receiptData> listreceipt) {
    return Column(
      children: listreceipt.map((e) => buildList(e)).toList(),
    );
  }

  Widget buildList(receiptData element) {
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 2, bottom: 2, left: 10),
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(border: Border.all(width: 2),borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            components().text(
                resturantsdata[int.parse(element.resturant_id)-1].resturant_name, FontWeight.normal, Colors.black, 22),
            components().text(element.bill_no.toString(),
                FontWeight.normal, Colors.black, 18),


          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => receipt(element: element, element_r: resturantsdata[int.parse(element.resturant_id) -1])));
      },
    )
      ;
  }

}
