import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:receipt_generator/components.dart';
import 'package:receipt_generator/list.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(date, time, list) => pw.Center(
      child: pw.Container(
        child: pw.Column(
          children: [
            pw.Container(
              // padding: pw.EdgeInsets.only(top: 20, bottom: 20),
              child: pw.Center(
                child: pw.Column(
                  children: [
                    pw.SizedBox(height: 8),
                    components().pwtext("Script all DNA", pw.FontWeight.bold,
                        PdfColors.grey900, 18),
                    pw.SizedBox(
                      height: 5,
                    ),
                    components().pwtext("806-808, Stayamev Eminence",
                        pw.FontWeight.normal, PdfColors.grey800, 10),
                    components().pwtext("Science City Road, Sola",
                        pw.FontWeight.normal, PdfColors.grey800, 10),
                    components().pwtext("Ahmedabad, 380060 ",
                        pw.FontWeight.normal, PdfColors.grey800, 10),
                    pw.SizedBox(
                      height: 3,
                    ),
                    components().pwtext("1234567890", pw.FontWeight.normal,
                        PdfColors.grey800, 10),
                    pw.SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            pw.Divider(height: 0, color: PdfColors.grey500, thickness: 1),
            pw.Container(
              padding: pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      components().pwtext("Dhairya Soni", pw.FontWeight.normal,
                          PdfColors.grey900, 13),
                      pw.SizedBox(
                        height: 2,
                      ),
                      components().pwtext("Receipt No : 1",
                          pw.FontWeight.normal, PdfColors.grey900, 13)
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      components().pwtext(
                          date, pw.FontWeight.normal, PdfColors.grey700, 11),
                      pw.SizedBox(
                        height: 2,
                      ),
                      components().pwtext(
                          time, pw.FontWeight.normal, PdfColors.grey700, 11)
                    ],
                  ),
                ],
              ),
            ),
            pw.Divider(height: 1, color: PdfColors.grey500, thickness: 1),
            pw.Container(
              padding: pw.EdgeInsets.only(top: 1, bottom: 1),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Container(
                    child: pw.Column(
                      children: [
                        components().pwtext("Items", pw.FontWeight.normal,
                            PdfColors.grey800, 11),
                      ],
                    ),
                  ),
                  pw.Container(
                    child: pw.Column(
                      children: [
                        components().pwtext(
                            "Qty", pw.FontWeight.normal, PdfColors.grey700, 11),
                      ],
                    ),
                  ),
                  pw.Container(
                    child: pw.Column(
                      children: [
                        components().pwtext("Price", pw.FontWeight.normal,
                            PdfColors.grey700, 11),
                      ],
                    ),
                  )
                ],
              ),
            ),
            pw.Divider(height: 1, color: PdfColors.grey500, thickness: 1),
            pw.Container(
              padding: pw.EdgeInsets.only(top: 3, bottom: 3),
              child: buildListWithScroll(list),
            ),
            pw.Divider(height: 1, color: PdfColors.grey500, thickness: 1),
            pw.Container(
                padding: pw.EdgeInsets.only(top: 3, bottom: 1, left: 0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.only(left: 5, bottom: 1),
                      child: components().pwtext("Add Ons",
                          pw.FontWeight.normal, PdfColors.grey900, 11),
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Container(
                          child: pw.Column(
                            children: [
                              components().pwtext("Add On 1",
                                  pw.FontWeight.normal, PdfColors.grey900, 11),
                              pw.SizedBox(
                                height: 2,
                              ),
                              components().pwtext("Add On 2",
                                  pw.FontWeight.normal, PdfColors.grey900, 11),
                            ],
                          ),
                        ),
                        pw.Container(
                          child: pw.Column(
                            children: [
                              components().pwtext("1", pw.FontWeight.normal,
                                  PdfColors.grey900, 11),
                              pw.SizedBox(
                                height: 2,
                              ),
                              components().pwtext("2", pw.FontWeight.normal,
                                  PdfColors.grey900, 11),
                            ],
                          ),
                        ),
                        pw.Container(
                          child: pw.Column(
                            children: [
                              components().pwtext("40", pw.FontWeight.normal,
                                  PdfColors.grey900, 11),
                              pw.SizedBox(
                                height: 2,
                              ),
                              components().pwtext("30", pw.FontWeight.normal,
                                  PdfColors.grey900, 11),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
            pw.Divider(height: 1, color: PdfColors.grey500, thickness: 1),
            pw.Container(
              padding: pw.EdgeInsets.only(top: 2, bottom: 2),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Container(
                    child: pw.Column(
                      children: [
                        components().pwtext("Sub Total", pw.FontWeight.normal,
                            PdfColors.grey700, 11),
                        pw.SizedBox(
                          height: 2,
                        ),
                        components().pwtext("CGST", pw.FontWeight.normal,
                            PdfColors.grey700, 11),
                        pw.SizedBox(
                          height: 2,
                        ),
                        components().pwtext("SGST", pw.FontWeight.normal,
                            PdfColors.grey700, 11),
                      ],
                    ),
                  ),
                  pw.Container(
                    child: pw.Column(
                      children: [
                        components().pwtext("".toString(), pw.FontWeight.normal,
                            PdfColors.grey700, 11),
                        pw.SizedBox(
                          height: 14,
                        ),
                        components().pwtext("2.5%".toString(),
                            pw.FontWeight.normal, PdfColors.grey700, 11),
                        pw.SizedBox(
                          height: 2,
                        ),
                        components().pwtext("2.5%".toString(),
                            pw.FontWeight.normal, PdfColors.grey700, 11),
                      ],
                    ),
                  ),
                  pw.Container(
                    child: pw.Column(
                      children: [
                        components().pwtext("1000", pw.FontWeight.normal,
                            PdfColors.grey700, 11),
                        pw.SizedBox(
                          height: 2,
                        ),
                        components().pwtext(
                            "10", pw.FontWeight.normal, PdfColors.grey700, 11),
                        pw.SizedBox(
                          height: 2,
                        ),
                        components().pwtext(
                            "10", pw.FontWeight.normal, PdfColors.grey700, 11),
                      ],
                    ),
                  )
                ],
              ),
            ),
            pw.Divider(height: 1, color: PdfColors.grey500, thickness: 1),
            pw.Padding(
              padding: pw.EdgeInsets.only(left: 0, right: 0, top: 2),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  components().pwtext(
                      "Total", pw.FontWeight.normal, PdfColors.grey900, 12),
                  components().pwtext(
                      "1020", pw.FontWeight.normal, PdfColors.grey900, 12)
                ],
              ),
            ),
            pw.Divider(height: 1, color: PdfColors.grey500, thickness: 1),
            pw.Container(
              padding: pw.EdgeInsets.only(left: 5, top: 5, right: 5),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  components().pwtext("Delivery Details", pw.FontWeight.normal,
                      PdfColors.grey900, 11),
                  pw.SizedBox(
                    height: 3,
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        components().pwtext("Dhairya Soni",
                            pw.FontWeight.normal, PdfColors.grey700, 11),
                        components().pwtext("1234567890", pw.FontWeight.normal,
                            PdfColors.grey700, 10),
                      ]),
                  pw.SizedBox(
                    height: 3,
                  ),
                  components().pwtext(
                      "104, Ashirwad Appartment, Near Rajnagar Busstop, Paldi Ahmedabad",
                      pw.FontWeight.normal,
                      PdfColors.grey700,
                      10),
                  pw.SizedBox(
                    height: 3,
                  ),
                  components().pwtext("Place it outside the door only",
                      pw.FontWeight.normal, PdfColors.grey900, 12),
                ],
              ),
            ),
            pw.SizedBox(
              height: 5,
            ),
            pw.Container(
              padding: pw.EdgeInsets.only(left: 5, right: 5),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  components().pwtext("Delivery Person Info",
                      pw.FontWeight.normal, PdfColors.grey900, 11),
                  pw.SizedBox(
                    height: 3,
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        components().pwtext("Rohan Shah", pw.FontWeight.normal,
                            PdfColors.grey700, 10),
                        components().pwtext("1234567890", pw.FontWeight.normal,
                            PdfColors.grey700, 10),
                      ]),
                  pw.SizedBox(
                    height: 6,
                  ),
                  pw.Align(
                    alignment: pw.Alignment.bottomCenter,
                    child: components().pwtext("Thank You for purchasing",
                        pw.FontWeight.normal, PdfColors.grey900, 11),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

pw.Widget buildListWithScroll(List<receiptData> list) {
  return pw.Column(
    children: list.map((e) => buildList(e)).toList(),
  );
}

pw.Widget buildList(receiptData element) {
  return pw.Container(
    padding: pw.EdgeInsets.only(top: 2, bottom: 2),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        pw.Container(
          child: pw.Column(
            children: [
              components().pwtext(element.itemName, pw.FontWeight.normal,
                  PdfColors.grey900, 11),
            ],
          ),
        ),
        pw.Container(
          child: pw.Column(
            children: [
              components().pwtext(element.quantity.toString(),
                  pw.FontWeight.normal, PdfColors.grey900, 11),
            ],
          ),
        ),
        pw.Container(
          child: pw.Column(
            children: [
              components().pwtext(element.price.toString(),
                  pw.FontWeight.normal, PdfColors.grey900, 11),
            ],
          ),
        )
      ],
    ),
  );
}
