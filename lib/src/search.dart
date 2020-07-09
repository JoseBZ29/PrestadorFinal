

import 'package:cloud_firestore/cloud_firestore.dart';

class search{
  searchByName(String searchField) {
    return Firestore.instance.collection('Profesiones')
    .where('Profecion', arrayContains: searchField.substring(0,1).toUpperCase())
    .getDocuments();
  }
}