// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:adimn_web/Seller/SellerModel.dart';
import 'package:adimn_web/Services/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SellerDataTable extends StatelessWidget {
  const SellerDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deletedata(id) async {
      await FirebaseFirestore.instance.collection('user').doc(id).delete();
    }

    FirebaseService _service = FirebaseService();
    Widget _sellerData({int? flex, String? text, Widget? widget}) {
      return Expanded(
        flex: flex!,
        child: Container(
          height: 66,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: widget ?? Text(text!),
          ),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _service.seller.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              Seller seller = Seller.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>);
              return Row(
                children: [
                  _sellerData(
                    flex: 1,
                    widget: Container(
                        height: 50,
                        width: 50,
                        child: Image.network(seller.storeImage!)),
                  ),
                  _sellerData(flex: 2, text: seller.storeName),
                  _sellerData(flex: 2, text: seller.address),
                  _sellerData(flex: 2, text: seller.emailAddress),
                  _sellerData(flex: 2, text: seller.contactNumber),
                ],
              );
            });
      },
    );
  }
}
