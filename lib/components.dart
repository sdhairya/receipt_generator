import "package:flutter/material.dart";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class components extends StatelessWidget {
  const components({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Text text(String data, FontWeight fontWeight, Color color, double fontsize) {
    return Text(
      data,
      style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: fontsize),
    );
  }

  pw.Text pwtext(String data, pw.FontWeight fontWeight, PdfColor color, double fontsize) {
    return pw.Text(
      data,
      style: pw.TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: fontsize),
    );
  }

}
