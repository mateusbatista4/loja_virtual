import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/screens/cart/components/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, child) {
          return ListView(
            children: cartManager.itens.map((e) => CartTile( e,)).toList(),
          );
        },
      ),
    );
  }
}
