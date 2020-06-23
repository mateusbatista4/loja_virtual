import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;
  ProductManager() {
    _loadAllProduts();
  }
  List<Product> allProducts = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
    
  }

  void setSearch(value){
    _search = value;
    notifyListeners();
    print(value+'3');
  }

  List<Product> get filteredProducts {
    List<Product> filteredProducts = [];
    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where(
          (prod) => prod.name.toLowerCase().contains(search),
        ),
      );
    }
    
    return filteredProducts;
    
  }

  _loadAllProduts() async {
    final QuerySnapshot snapshotQuery =
        await firestore.collection('products').getDocuments();

    allProducts =
        snapshotQuery.documents.map((e) => Product.fromDocument(e)).toList();

    notifyListeners();
  }
}
