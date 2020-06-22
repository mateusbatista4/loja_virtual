import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/products/components/products_list_tile.dart';
import 'package:loja_virtual/screens/products/components/serach_dialog.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Produtos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => SearchDialog(),
              );
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) => ListView.builder(
          itemCount: productManager.allProducts.length,
          itemBuilder: (_, index) {
            return ProductsListTile(
              product: productManager.allProducts[index],
            );
          },
        ),
      ),
    );
  }
}
