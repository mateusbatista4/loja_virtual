import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';

class CartManager {
  List<CartProduct> itens = [];
  void addToCart(Product prod) {
    itens.add(CartProduct.fromProduct(prod));
  }
}
