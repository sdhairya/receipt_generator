import 'package:flutter/material.dart';
import 'package:receipt_generator/resturantsLists/resturantsLists.dart';
import 'package:receipt_generator/supabasehandler.dart';
import 'package:receipt_generator/viewReceipt/viewReceipt.dart';
import 'package:supabase/supabase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return resturantsLists();
  }
}
