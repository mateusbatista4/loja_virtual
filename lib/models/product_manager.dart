import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;
  ProductManager() {
    _loadAllProduts();
  }
  List<Product> allProducts = [];

  _loadAllProduts() async {
    final QuerySnapshot snapshotQuery =
        await firestore.collection('products').getDocuments();

    allProducts =
        snapshotQuery.documents.map((e) => Product.fromDocument(e)).toList();

    notifyListeners();
  }
}
