import 'package:flutter/material.dart';
import 'package:receipt_generator/supabasehandler.dart';
import 'package:supabase/supabase.dart';

import '../components.dart';
import '../list.dart';
import '../viewReceipt/receipt.dart';

class body extends StatefulWidget {

  // final List<receiptData> resturants_receipt;
  final resturants resturant;
  final String resturant_id;
  const body({Key? key,required this.resturant, required this.resturant_id}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {


  @override
  void initState() {
    super.initState();
  }

  List<receiptData> receiptdata = [];
  List<receiptData> resturants_receipt = [];

  @override
  Widget build(BuildContext context) {
    final _stream = SupaBaseHandler().client.from("receipt_details:resturant_id=eq.${widget.resturant_id}").stream(primaryKey: ['id']);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child:
          StreamBuilder(
            stream: _stream,
            builder: (context,snapshot){
              // print(snapshot.data);
              SupaBaseHandler().client.from("receipt_details").stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
                  setState(() {
                    resturants_receipt = SupaBaseHandler().parse_filterData(data, widget.resturant_id);
                  });

                // print(resturants_receipt);
                // buildListWithScroll(resturants_receipt);
              });

              return buildListWithScroll(resturants_receipt);
            },
          )
        ),
      ),
    );
  }

  Widget buildListWithScroll(List<receiptData> receipts) {
    return Column(
      children: receipts.map((e) => buildList(e)).toList(),
    );
  }

  Widget buildList(receiptData element) {

    return
      InkWell(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(width: 1),borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            components().text(
                "Bill No: "+element.bill_no, FontWeight.normal, Colors.black54, 18),
            SizedBox(height: 6,),

            components().text("Customer Name: "+element.customer_name, FontWeight.normal, Colors.black87, 20)

          ],
        ),
      ),
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => receiptList(resturant_id: widget.resturantsdata.indexOf(element)+1,)));

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => receipt(element: element, element_r: widget.resturant)));
      },
    )
    ;
  }

}
