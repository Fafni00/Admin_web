import 'package:adimn_web/Category/CategoryPage.dart';
import 'package:adimn_web/Category/Maincategory.dart';
import 'package:adimn_web/Category/SubCategory.dart';
import 'package:adimn_web/Homepage/Category.dart';
import 'package:adimn_web/Homepage/Homepage.dart';
import 'package:adimn_web/Seller/SellerList.dart';
import 'package:adimn_web/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sar Admin DashBoard',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Loginpage(),
        routes: {
          HomePage.id: (context) => HomePage(),
          Category.id: (context) => Category(),
          SellerList.id: (context) => SellerList(),
          MainCategory.id: (context) => MainCategory(),
          SubCategory.id: (context) => SubCategory()
        });
  }
}
