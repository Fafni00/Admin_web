import 'package:adimn_web/Category/CategoryPage.dart';
import 'package:adimn_web/sidebar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class Category extends StatelessWidget {
  static const String id = 'category-page';
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff023020),
        title: const Text('Category'),
      ),
      sideBar: _sidebar.sidebarMenus(context, Category.id),
      body: SingleChildScrollView(
        child: CategoryPage(),
      ),
    );
  }
}
