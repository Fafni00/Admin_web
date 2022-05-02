// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:adimn_web/Services/Firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../CategoryModules/mainCategorylist.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({Key? key}) : super(key: key);

  @override
  State<MainCategoryPage> createState() => _MainCategoryPageState();
}

class _MainCategoryPageState extends State<MainCategoryPage> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseService _service = FirebaseService();
  final TextEditingController mainCategory = TextEditingController();
  bool _nocategorySelected = false;
  QuerySnapshot? snapshot;
  Object? _selectedValue;

  Widget _dropdownButton() {
    return DropdownButton(
        value: _selectedValue,
        hint: const Text('Select Category'),
        items: snapshot!.docs.map((e) {
          return DropdownMenuItem<String>(
            value: e['categoryName'],
            child: Text(e['categoryName']),
          );
        }).toList(),
        onChanged: (selectedCat) {
          setState(() {
            _selectedValue = selectedCat;
            _nocategorySelected = false;
          });
        });
  }

  clear() {
    setState(() {
      _selectedValue = null;
      mainCategory.clear();
    });
  }

  @override
  void initState() {
    getCateList();
    super.initState();
  }

  getCateList() {
    return _service.categories.get().then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: const Text(
                'Main Category',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                    color: Color(0xFF056608)),
              ),
            ),
            const Divider(
              color: Color(0xFF056608),
            ),
            snapshot == null ? Text('Loading..') : _dropdownButton(),
            SizedBox(
              height: 8,
            ),
            if (_nocategorySelected == true)
              Text(
                'No Category Selected',
                style: TextStyle(color: Color(0xFF056608)),
              ),
            SizedBox(
                width: 200,
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Main Category Name';
                      }
                      return null;
                    },
                    controller: mainCategory,
                    decoration: InputDecoration(
                      label: Text(
                        'Enter Category Name',
                      ),
                    ))),
            SizedBox(height: 20),
            Row(children: [
              TextButton(
                  onPressed: clear,
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: Color(0xFF056608))),
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFF056608),
                      ))),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    if (_selectedValue == null) {
                      setState(() {
                        _nocategorySelected == true;
                      });
                      return;
                    }
                    if (_formkey.currentState!.validate()) {
                      EasyLoading.show();
                      _service.saveCategories(
                        data: {
                          'category': _selectedValue, //for dropdown
                          'mainCategory': mainCategory.text,
                          'approved': true //for text from
                        },
                        reference: _service.mainCategories,
                        docName: mainCategory.text,
                      ).then((value) {
                        clear();
                        EasyLoading.dismiss();
                      });
                    }
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: Color(0xFF056608))),
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFF056608),
                      ))),
            ]),
            const Divider(
              color: Color(0xFF056608),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Main Category List',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                      color: Color(0xFF056608)),
                )),
            SizedBox(height: 20),
            const Divider(
              color: Color(0xFF056608),
            ),
            MainCategoriesList(),
          ],
        ),
      ),
    );
  }
}
