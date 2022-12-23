
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
import 'package:receipt_generator/utils.dart';

import 'package:receipt_generator/viewReceipt/previewScreen.dart';
import 'package:receipt_generator/viewReceipt/printable_data.dart';
import 'package:bluetooth_print/bluetooth_print.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  Uint8List bytes = Uint8List.fromList([0]);
  List<receiptData> list = [
    receiptData(itemName: "Item 1", quantity: 1, price: 100.0),
    receiptData(itemName: "Item 2", quantity: 4, price: 200.0),
    receiptData(itemName: "Item 3", quantity: 2, price: 900.0),
    receiptData(itemName: "Item 4", quantity: 4, price: 200.0),
    receiptData(itemName: "Item 5", quantity: 4, price: 200.0),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey globalKey = GlobalKey();

    DateTime today = DateTime.now();
    String date = "${today.day}-${today.month}-${today.year}";
    String time = "${today.hour}:${today.minute}";
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
                    final bytes = await Utils.capture(globalKey);
                    setState(() {
                      this.bytes = bytes;
                    });
                    printDoc(date, time, bytes);
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
                  RepaintBoundary(
                    key: globalKey,
                    child: Center(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              // padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 8),
                                    components().text("Script all DNA",
                                        FontWeight.bold, Colors.black87, 18),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    components().text(
                                        "806-808, Stayamev Eminence",
                                        FontWeight.normal,
                                        Colors.black45,
                                        10),
                                    components().text("Science City Road, Sola",
                                        FontWeight.normal, Colors.black45, 10),
                                    components().text("Ahmedabad, 380060 ",
                                        FontWeight.normal, Colors.black45, 10),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    components().text("1234567890",
                                        FontWeight.normal, Colors.black45, 10),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                                height: 0, color: Colors.grey, thickness: 1),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              // width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      components().text(
                                          "Dhairya Soni",
                                          FontWeight.normal,
                                          Colors.black87,
                                          13),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      components().text("Receipt No : 1",
                                          FontWeight.normal, Colors.black87, 13)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      components().text(date, FontWeight.normal,
                                          Colors.black45, 11),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      components().text(time, FontWeight.normal,
                                          Colors.black45, 11)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                height: 1, color: Colors.grey, thickness: 1),
                            Container(
                              padding: EdgeInsets.only(top: 1, bottom: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        components().text(
                                            "Items",
                                            FontWeight.normal,
                                            Colors.black45,
                                            13),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        components().text(
                                            "Qty",
                                            FontWeight.normal,
                                            Colors.black45,
                                            13),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        components().text(
                                            "Price",
                                            FontWeight.normal,
                                            Colors.black45,
                                            13),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                                height: 1, color: Colors.grey, thickness: 1),
                            Container(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: buildListWithScroll(list),
                            ),
                            Divider(
                                height: 1, color: Colors.grey, thickness: 1),
                            Container(
                                padding:
                                    EdgeInsets.only(top: 3, bottom: 1, left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 0, bottom: 1),
                                      child: components().text(
                                          "Add Ons",
                                          FontWeight.normal,
                                          Colors.black87,
                                          11),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              components().text(
                                                  "Add On 1",
                                                  FontWeight.normal,
                                                  Colors.black87,
                                                  11),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              components().text(
                                                  "Add On 2",
                                                  FontWeight.normal,
                                                  Colors.black87,
                                                  11),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              components().text(
                                                  "1",
                                                  FontWeight.normal,
                                                  Colors.black87,
                                                  11),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              components().text(
                                                  "2",
                                                  FontWeight.normal,
                                                  Colors.black87,
                                                  11),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              components().text(
                                                  "40",
                                                  FontWeight.normal,
                                                  Colors.black87,
                                                  11),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              components().text(
                                                  "30",
                                                  FontWeight.normal,
                                                  Colors.black87,
                                                  11),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Divider(
                                height: 1, color: Colors.grey, thickness: 1),
                            Container(
                              padding: EdgeInsets.only(top: 2, bottom: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        components().text(
                                            "Sub Total",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        components().text(
                                            "CGST",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        components().text(
                                            "SGST",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        components().text(
                                            "".toString(),
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        components().text(
                                            "2.5%".toString(),
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        components().text(
                                            "2.5%".toString(),
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        components().text(
                                            "1000",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        components().text(
                                            "10",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        components().text(
                                            "10",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                                height: 1, color: Colors.grey, thickness: 1),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 0, right: 0, top: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  components().text("Total", FontWeight.normal,
                                      Colors.black, 13),
                                  // SizedBox(width: 10),
                                  components().text("1020", FontWeight.normal,
                                      Colors.black87, 13)
                                ],
                              ),
                            ),
                            Divider(
                                height: 1, color: Colors.grey, thickness: 1),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 0, top: 5, right: 0),
                              // width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  components().text("Delivery Details",
                                      FontWeight.normal, Colors.black87, 12),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        components().text(
                                            "Dhairya Soni",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        components().text(
                                            "1234567890",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                      ]),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  components().text(
                                      "104, Ashirwad Appartment, Near Rajnagar Busstop, Paldi Ahmedabad",
                                      FontWeight.normal,
                                      Colors.black45,
                                      11),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  components().text(
                                      "Place it outside the door only",
                                      FontWeight.normal,
                                      Colors.black87,
                                      12),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              // padding: EdgeInsets.only(left: 5, right: 5),
                              // width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  components().text("Delivery Person Info",
                                      FontWeight.normal, Colors.black87, 12),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        components().text(
                                            "Rohan Shah",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                        components().text(
                                            "1234567890",
                                            FontWeight.normal,
                                            Colors.black45,
                                            11),
                                      ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: components().text(
                                        "Thank You for purchasing",
                                        FontWeight.normal,
                                        Colors.black87,
                                        12),
                                  )
                                ],
                              ),
                            ),
                            DottedLine(
                              direction: Axis.horizontal,
                              dashColor: Colors.black,
                              dashGapColor: Colors.white,
                              dashGapLength: 2.0,
                            ),
                            SizedBox(height: 2,)
                          ],
                        ),
                      ),
                    ),
                  ),

                  bytes == "" ? Container() : buildImage(bytes)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();

  Future<void> printDoc(date, time, bytes) async {
    final doc = pw.Document();
    // doc.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.roll80,
    //     // PdfPageFormat(8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),
    //     margin: pw.EdgeInsets.zero,
    //     build: (context) {
    //       return buildPrintableData(date, time, list);
    //     }));
    doc.addPage(
      pw.Page(
          margin: pw.EdgeInsets.zero,
          pageFormat: PdfPageFormat.roll80,
          build: (context){return pw.Image(pw.MemoryImage(bytes));})
    );

    List<LineText> list1 = [];
    String base64Image = base64Encode(bytes);
    list1.add(LineText(type: LineText.TYPE_IMAGE, x:10, y:10, content: base64Image,));

    // await GallerySaver.saveImage(bytes, toDcim: true);


    // Map<String, dynamic> config = Map();
    // await bluetoothPrint.printReceipt(config,list1);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => bluetoothDevicesScreen(list: list1,bytes: bytes,)));

    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => previewScreen(doc:doc,list: list1,)));
  }

  Widget buildListWithScroll(List<receiptData> list) {
    return Column(
      children: list.map((e) => buildList(e)).toList(),
    );
  }

  Widget buildList(receiptData element) {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                components().text(
                    element.itemName, FontWeight.normal, Colors.black, 12),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                components().text(element.quantity.toString(),
                    FontWeight.normal, Colors.black, 12),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                components().text(element.price.toString(), FontWeight.normal,
                    Colors.black, 12),
              ],
            ),
          )
        ],
      ),
    );
  }
}
