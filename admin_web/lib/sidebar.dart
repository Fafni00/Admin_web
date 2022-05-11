import 'package:adimn_web/Category/Maincategory.dart';
import 'package:adimn_web/Category/SubCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'Homepage/Category.dart';
import 'Homepage/Homepage.dart';
import 'Seller/SellerList.dart';

class SideBarWidget {
  sidebarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Color(0xff467F3B),
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: HomePage.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Categories',
          route: Category.id,
          icon: Icons.category,
        ),
        MenuItem(
          title: 'MainCategory',
          route: MainCategory.id,
        ),
        MenuItem(
          title: 'SubCategory',
          route: SubCategory.id,
        ),
        MenuItem(
          title: 'Seller',
          route: SellerList.id,
          icon: Icons.group,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xff008000),
        child: const Center(
          child: Text(
            'MENU ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xff008000),
        child: const Center(
          child: Text(
            'SIGNOUT',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
