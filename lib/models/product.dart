import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/item_size.dart';

class Product extends ChangeNotifier{


  Product.fromDocument(DocumentSnapshot doc){
    id = doc.documentID;
    name = doc['name'] as String;
    description = doc['description'] as String;
    images = List<String>.from(doc.data['images'] as List<dynamic>);
    sizes = (doc.data['stock'] as List<dynamic> ?? []).map((e) => ItemSize.fromMap(e as Map<String,dynamic>)).toList();

    print(sizes);
  }
  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  ItemSize _selectedSize;

  set selectedSize(ItemSize value){
    _selectedSize = value;
    notifyListeners();
  }

  ItemSize get selectedSize => _selectedSize;

}