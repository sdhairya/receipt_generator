import 'package:flutter/material.dart';
import 'package:receipt_generator/resturantsLists/body.dart';

import '../list.dart';
import '../supabasehandler.dart';

class resturantsLists extends StatefulWidget {
  const resturantsLists({Key? key}) : super(key: key);

  @override
  State<resturantsLists> createState() => _resturantsListsState();
}

class _resturantsListsState extends State<resturantsLists> {

  List<receiptData> receiptdata = [];
  List<resturants> resturantsdata = [];


  @override
  void initState() {
    // getData();
    receiptdata.clear();
    resturantsdata.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    if (receiptdata.isEmpty && resturantsdata.isEmpty) {
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

    return body(resturantsdata: resturantsdata,);
  }
}

