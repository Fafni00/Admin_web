import 'package:adimn_web/Services/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SellerList extends StatelessWidget {
  static const String id = 'seller-page';
  const SellerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff023020),
        title: const Text('Seller List'),
      ),
      sideBar: _sidebar.sidebarMenus(context, SellerList.id),
      body: SingleChildScrollView(),
    );
  }
}
