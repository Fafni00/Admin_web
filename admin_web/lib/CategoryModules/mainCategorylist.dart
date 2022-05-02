import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Services/Firebase_service.dart';

class MainCategoriesList extends StatefulWidget {
  const MainCategoriesList({Key? key}) : super(key: key);

  @override
  State<MainCategoriesList> createState() => _MainCategoriesListState();
}

class _MainCategoriesListState extends State<MainCategoriesList> {
  final FirebaseService _service = FirebaseService();
  Object? _selectedValue;
  QuerySnapshot? snapshot;

  Widget categoryWidget(data) {
    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(data['mainCategory'])),
        ));
  }

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
          });
        });
  }

  void initstate() {
    getCateList();
    super.initState();
  }

  getCateList() {
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
        // snapshot == null ? const Text('Loading..') : _dropdownButton(),
        const SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
            stream: _service.mainCategories
                .where('category', isEqualTo: _selectedValue)
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
                    childAspectRatio: 6 / 5,
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
