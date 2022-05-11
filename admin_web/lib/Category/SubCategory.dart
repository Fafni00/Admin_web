import 'package:adimn_web/Category/SubCategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../sidebar.dart';
import 'CategoryPage.dart';

class SubCategory extends StatelessWidget {
  static const String id = 'subcategory-page';
  const SubCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff023020),
        title: const Text('Category'),
      ),
      sideBar: _sidebar.sidebarMenus(context, SubCategory.id),
      body: SingleChildScrollView(
        child: SubCategoryPage(),
      ),
    );
  }
}
