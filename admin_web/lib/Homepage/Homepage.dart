import 'package:adimn_web/Homepage/Category.dart';
import 'package:adimn_web/Seller/SellerList.dart';
import 'package:adimn_web/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff023020),
          title: const Text('Admin DashBoard'),
        ),
        sideBar: _sidebar.sidebarMenus(context, HomePage.id),
        body: Column(children: [
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/assets/decor.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 50),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Category()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: Color(0xff008000).withOpacity(0.3),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: Color(0xff008000).withOpacity(0.3),
                                ),
                              ]),
                          height: 150,
                          width: 150,
                          child: Image.asset(
                            'images/assets/admincategories.png',
                            fit: BoxFit.contain,
                          ),
                        )),
                    Text('Categories',
                        style:
                            TextStyle(color: Color(0xff023020), fontSize: 20)),
                  ],
                ),
                Row(children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SellerList()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: Color(0xff008000).withOpacity(0.3),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: Color(0xff008000).withOpacity(0.3),
                                ),
                              ]),
                          height: 150,
                          width: 150,
                          child: Image.asset(
                            'images/assets/sellerlist.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text('SellerList',
                          style: TextStyle(
                              color: Color(0xff023020), fontSize: 20)),
                    ],
                  ),
                ]),
              ],
            ),
          )
        ]));
  }
}
