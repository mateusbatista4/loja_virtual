import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class CartManager {
  List<CartProduct> itens = [];
  User user;
  
  void updateUser(UserManager userManager){
    user =  userManager.user;
    itens.clear();

    if(user != null){
      _loadCartItens();
    }
  }

  Future<void>_loadCartItens() async {
    
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    
    itens = cartSnap.documents .map((e) => CartProduct.formDocument(e)).toList();
    
  }

  void addToCart(Product prod) {
    itens.add(CartProduct.fromProduct(prod));
  }


}
