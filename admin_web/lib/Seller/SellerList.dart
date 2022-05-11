import 'package:adimn_web/Seller/SellerDatatable.dart';
import 'package:adimn_web/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SellerList extends StatelessWidget {
  static const String id = 'seller-page';
  const SellerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _rowHeader({int? flex, String? text}) {
      return Expanded(
          flex: flex!,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey.shade400),
            child: Padding(padding: EdgeInsets.all(8.0), child: Text(text!)),
          ));
    }

    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff023020),
        title: const Text('Registered Seller'),
      ),
      sideBar: _sidebar.sidebarMenus(context, SellerList.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SellerList',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
            ),
            Row(
              children: [
                _rowHeader(flex: 1, text: 'Store Image'),
                _rowHeader(flex: 2, text: 'Store Name'),
                _rowHeader(flex: 2, text: 'Address'),
                _rowHeader(flex: 2, text: 'Email'),
                _rowHeader(flex: 2, text: 'ContactNumber'),
              ],
            ),
            SellerDataTable()
          ],
        ),
      ),
    );
  }
}
