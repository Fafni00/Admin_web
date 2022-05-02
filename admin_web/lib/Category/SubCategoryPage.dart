// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../CategoryModules/categorieslist.dart';
import '../Services/Firebase_service.dart';

class SubCategoryPage extends StatefulWidget {
  static const String id = 'subcategory';
  const SubCategoryPage({Key? key}) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseService _service = FirebaseService();
  final TextEditingController _subCategoryName = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  dynamic image;
  String? fileName;
  Object? _selectedValue;
  bool _nocategorySelected = false;
  QuerySnapshot? snapshot;

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
            _nocategorySelected = false;
          });
        });
  }

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
        .ref('subCategoryImage/$fileName');
    try {
      String? mimiType = mime(
        basename(fileName!),
      );
      var metaData = firebase_storage.SettableMetadata(contentType: mimiType);
      firebase_storage.TaskSnapshot uploadSnapshot =
          await ref.putData(image, metaData);
      // get the download link of the the saved image
      String downloadURL =
          await uploadSnapshot.ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          //to save data to firestore
          _service.saveCategories(
              data: {
                'subCategoryName': _subCategoryName.text,
                'mainCategory': _selectedValue,
                'image': value,
                'active': true
              },
              docName: _subCategoryName.text,
              reference: _service.subCategories).then((value) {
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
      _subCategoryName.clear();
      image = null;
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
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sub Category',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                  color: Color(0xFF056608)),
            ),
          ),
          Divider(
            color: Color(0xFF056608),
          ),
          Row(
            children: [
              const SizedBox(
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
                        ? Text('Sub Category Image')
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
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snapshot == null ? Text('Loading..') : _dropdownButton(),
                  SizedBox(
                    height: 8,
                  ),
                  if (_nocategorySelected == true)
                    Text(
                      'No Main Category Selected',
                      style: TextStyle(color: Color(0xFF056608)),
                    ),
                  SizedBox(
                      width: 200,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Sub Category Name';
                            }
                            return null;
                          },
                          controller: _subCategoryName,
                          decoration: InputDecoration(
                            label: Text(
                              'Enter Sub Category Name',
                            ),
                          ))),
                  SizedBox(height: 20),
                  Row(children: [
                    TextButton(
                        onPressed: clear,
                        child: Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(color: Color(0xFF056608))),
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFF056608),
                            ))),
                    SizedBox(width: 10),
                    if (image != null)
                      ElevatedButton(
                          onPressed: () {
                            if (_selectedValue == null) {
                              setState(() {
                                _nocategorySelected == true;
                              });
                              return;
                            }
                            if (_formkey.currentState!.validate()) {
                              saveImageToDb();
                            }
                          },
                          child: Text('Save',
                              style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Color(0xFF056608))),
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF056608),
                              ))),
                  ]),
                ],
              )
            ],
          ),
          Divider(
            color: Color(0xFF056608),
          ),
          Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sub Category List',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                    color: Color(0xFF056608)),
              )),
          SizedBox(height: 10),
          CategoriesList(
            reference: _service.subCategories,
          ),
        ],
      ),
    );
  }
}
