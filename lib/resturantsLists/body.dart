import 'package:flutter/material.dart';
import 'package:receipt_generator/receiptsList/receiptList.dart';

import '../components.dart';
import '../list.dart';
import '../supabasehandler.dart';
import '../viewReceipt/receipt.dart';

class body extends StatefulWidget {
  // final List<receiptData> receiptdata;
  final List<resturants> resturantsdata;
  const body({Key? key, required this.resturantsdata}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<resturants> resturantsList=[];

  @override
  Widget build(BuildContext context) {
    final _stream = SupaBaseHandler().client.from("resturant_master").stream(primaryKey: ['id']);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: components()
              .text("Resturants", FontWeight.bold, Colors.white, 20),
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
          child: StreamBuilder(
            stream: _stream,
            builder: (context,snapshot){
              // print(snapshot.data);
              SupaBaseHandler().client.from("resturant_master").stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
                setState(() {
                  resturantsList = SupaBaseHandler().parse_filterDataResturants(data);
                });

                // print(resturantsList);
                // buildListWithScroll(resturants_receipt);
              });

              return buildListWithScroll(resturantsList);
            },
          )
          // LayoutBuilder(builder: (context, constraints) {
          //   return AnimatedContainer(
          //     duration: Duration(milliseconds: 500),
          //     child: Column(
          //       children: [
          //         buildListWithScroll(widget.resturantsdata)
          //       ],
          //     ),
          //   );
          // }),
        ),
      ),
    );
  }

  Widget buildListWithScroll(List<resturants> listresturants) {
    return Column(
      children: listresturants.map((e) => buildList(e)).toList(),
    );
  }

  Widget buildList(resturants element) {

    List<receiptData> receipts = [];
    // print(resturantsList.indexOf(element));
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
                element.resturant_name, FontWeight.normal, Colors.black, 22),

          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => receiptList(resturant_id: resturantsList.indexOf(element)+1,resturant: element,)));

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => receipt(element: element, element_r: widget.resturantsdata[int.parse(element.resturant_id) -1])));
      },
    )
    ;
  }

}
