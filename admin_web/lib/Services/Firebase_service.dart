import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCategories =
      FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories =
      FirebaseFirestore.instance.collection('subCategories');
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> saveCategories(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).set(data);
  }
}
