// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:adimn_web/Services/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SellerDataTable extends StatelessWidget {
  const SellerDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    return StreamBuilder(
      stream:
          _service.seller.orderBy('storeName', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return DataTable(
          showBottomBorder: true,
          dataRowHeight: 60,
          headingRowColor: MaterialStateProperty.all(Colors.white),
          columns: <DataColumn>[
            DataColumn(
              label: Text('Active/Inactive'),
            ),
            DataColumn(
              label: Text('Top Picked'),
            ),
            DataColumn(
              label: Text('Shop Name'),
            ),
            DataColumn(
              label: Text('Contact'),
            ),
            DataColumn(
              label: Text('Email'),
            ),
          ],
          rows: _sellerDetailsRows(snapshot.data),
        );
      },
    );
  }

  List<DataRow> _sellerDetailsRows(QuerySnapshot snapshot) {}
}
