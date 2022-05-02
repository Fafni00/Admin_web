// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Services/Firebase_service.dart';

class CategoriesList extends StatefulWidget {
  final CollectionReference? reference;
  const CategoriesList({this.reference, Key? key}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  FirebaseService _service = FirebaseService();
  Object? _selectedValue;
  bool _nocategorySelected = false;
  QuerySnapshot? snapshot;

  Widget categoryWidget(data) {
    return Card(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(height: 20),
              Container(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.network(data['image']),
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color(0xFF90EE90).withOpacity(0.2),
                      blurRadius: 0.1,
                    ),
                  ])),
              Text(widget.reference == _service.categories
                  ? data['categoryName']
                  : data['subCategoryName'])
            ])));
  }

  Widget _dropdownButton() {
    return DropdownButton(
        value: _selectedValue,
        hint: const Text('Select Category'),
        items: snapshot!.docs.map((e) {
          return DropdownMenuItem<String>(
            value: e['mainCategory'],
            child: Text(e['mainCategory']),
          );
        }).toList(),
        onChanged: (selectedCat) {
          setState(() {
            _selectedValue = selectedCat;
          });
        });
  }

  @override
  void initState() {
    getMainCatList();
    super.initState();
  }

  getMainCatList() {
    return _service.mainCategories.get().then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.reference == _service.subCategories && snapshot != null)
          Row(
            children: [
              _dropdownButton(),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedValue = null;
                    });
                  },
                  child: const Text('Show All'))
            ],
          ),
        SizedBox(height: 20),
        StreamBuilder<QuerySnapshot>(
            stream: widget.reference!
                .where('mainCategory', isEqualTo: _selectedValue)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              }
              if (snapshot.data!.size == 0) {
                return Text('No Categories Added');
              }

              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return categoryWidget(data);
                  });
            }),
      ],
    );
  }
}
