// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:adimn_web/Services/Firebase_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

import '../CategoryModules/categorieslist.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseService _service = FirebaseService();
  final TextEditingController _categoryName = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  dynamic image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    } else {
      //incase of failure to pick image or user cancellation
      print('Cancelled of failed');
    }
  }

  saveImageToDb() async {
    EasyLoading.show();
    var ref = firebase_storage.FirebaseStorage.instance
        .ref('categoryImage/$fileName');
    try {
      await ref.putData(image);
      String downloadURL = await ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          //to save data to firestore
          _service.saveCategories(
              data: {
                'categoryName': _categoryName.text,
                'image': value,
                'active': true
              },
              docName: _categoryName.text,
              reference: _service.categories).then((value) {
            clear();
            EasyLoading.dismiss();
          });
        }
        return value;
      });
    } on FirebaseException catch (e) {
      clear();
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  clear() {
    setState(() {
      _categoryName.clear();
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Categories',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
                color: Color(0xFF056608)),
          ),
        ),
        Divider(
          color: Color(0xFF056608),
        ),
        Row(children: [
          SizedBox(
            width: 10,
          ),
          Column(children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: image == null
                    ? Text('Category Image')
                    : Image.memory(image),
              ),
              alignment: Alignment.center,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Upload Image'),
              onPressed: pickImage,
            ),
          ]),
          SizedBox(width: 20),
          Container(
              width: 200,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Category Name';
                  }
                  return null;
                },
                controller: _categoryName,
                decoration: InputDecoration(
                    label: Text(
                      'Enter Category Name',
                    ),
                    contentPadding: EdgeInsets.zero),
              )),
          SizedBox(width: 10),
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
          image == null
              ? Container()
              : ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      saveImageToDb();
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
              'Category List',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                  color: Color(0xFF056608)),
            )),
        SizedBox(height: 10),
        CategoriesList(
          reference: _service.categories,
        ),
      ]),
    );
  }
}
