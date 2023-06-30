import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:receipt_generator/list.dart';
import 'package:supabase/supabase.dart';

import 'list.dart';


class SupaBaseHandler {
  static String supabaseUrl = "https://xnibmxheuavdtnuliliq.supabase.co";
  static String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuaWJteGhldWF2ZHRudWxpbGlxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzIyMDc0MDQsImV4cCI6MTk4Nzc4MzQwNH0.WvDrnyCtEKAlJDV0mqTrNiXD2ZPQgyAeyoS5JOsWz-c";

  final client = SupabaseClient(supabaseUrl, supabaseKey);

  Future<List<receiptData>?> readreceiptData(int resturant_id) async {
    // print(resturant_id);
    var response_receipt = await client.from("receipt_details")
        .select(
        '''id, resturant_id, customer_name, billing_date, billing_time, items, addon_items,cgst_percent, sgst_percent, cgst, sgst, total, bill_no, subtotal''').eq("resturant_id", resturant_id)
        .execute();
    List<receiptData> listReceipt = [];
    // print(response_receipt.data);
    final receipt_details = response_receipt.data as List;
    receipt_details
        .forEach((element) => listReceipt.add(getreceiptData(element)));


    if(listReceipt.isEmpty){
      return null;
    }
    return listReceipt;
  }

  parse_filterData(data, resturant_id){
    List<receiptData> listReceipt = [];
    List<receiptData> resturants_receipt = [];
    final receipt_details = data as List;
    receipt_details
        .forEach((element) => listReceipt.add(getreceiptData(element)));
    for (var i = 0; i < listReceipt.length; i++) {
      // print(receiptdata[i].resturant_id);
      if (listReceipt[i].resturant_id.toString() ==
          resturant_id.toString()) {
        resturants_receipt.add(listReceipt[i]);
      }
    }
    // print(resturants_receipt[0].id);
    return resturants_receipt;
    // print(resturants_receipt);
    // print(resturants_receipt.length);
  }

  parse_filterDataResturants(data){
    List<resturants> rest = [];
    List<resturants> listResturants =[];
    final rests = data as List;
    rests
        .forEach((element) => listResturants.add(getresturantData(element)));
    // print(resturants_receipt[0].id);
    return listResturants;
    // print(resturants_receipt);
    // print(resturants_receipt.length);
  }


  Future<List<resturants>> readresturantData() async {
    var response_resturant = await client.from("resturant_master").select(
        '''resturant_name, resturant_address, resturant_mobile''').execute();
    final resturant_details = response_resturant.data as List;
    List<resturants> listresturants = [];
    resturant_details.forEach((e) => listresturants.add(getresturantData(e)));
    return listresturants;
  }

  resturants getresturantData(Map<String, dynamic> record) {
    resturants object = resturants(
        resturant_name: record['resturant_name'],
        resturant_address: record['resturant_address'],
        resturant_mobile: record['resturant_mobile']);

    return object;
  }

  receiptData getreceiptData(Map<String, dynamic> record) {
    receiptData object = receiptData(
        customer_name: record['customer_name'],
        date: record['billing_date'],
        time: record['billing_time'],
        cgst_percent: record['cgst_percent'].toString(),
        sgst_percent: record['sgst_percent'].toString(),
        cgst: record['cgst'].toString(),
        sgst: record['sgst'].toString(),
        total: record['total'].toString(),
        bill_no: record['bill_no'].toString(),
        subtotal: record['subtotal'].toString(),
        resturant_id: record['resturant_id'].toString());
    object.items = getItemsList(record['items'], 'items');
    object.addon_items = getItemsList(record['addon_items'], 'addon_items');

    return object;
  }

  List<receiptsitems> getItemsList(records, String item) {
    List<receiptsitems> listitems = [];
print(records);
    if (records == null) return [];
    records.forEach((e) => listitems.add(getitems(e)));
    return listitems;
  }

  receiptsitems getitems(records) {

    receiptsitems object = receiptsitems(items: records[0], qty: records[1], price:records[2]);
    return object;
  }
}
