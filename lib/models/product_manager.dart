import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;

  List<Product> _allProducts = [];

  ProductManager() {
    _loadAllProduts();
  }
  _loadAllProduts() async {
    final QuerySnapshot snapshotQuery =
        await firestore.collection('products').getDocuments();

    _allProducts =
        snapshotQuery.documents.map((e) => Product.fromDocument(e)).toList();

    notifyListeners();
  }
}
