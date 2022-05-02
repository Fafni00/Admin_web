import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../Services/sidebar.dart';
import 'MaincategoryPage.dart';

class MainCategory extends StatelessWidget {
  static const String id = 'maincategory-page';
  const MainCategory({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff023020),
        title: const Text('Category'),
      ),
      sideBar: _sidebar.sidebarMenus(context, MainCategory.id),
      body: SingleChildScrollView(
        child: MainCategoryPage(),
      ),
    );
  }
}
