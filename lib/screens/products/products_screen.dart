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
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return Text("Produtos");
            } else {
              return LayoutBuilder(
                builder: (_, constrains) {
                  return InkWell(
                    splashColor: Theme.of(context).primaryColor,
                    onTap: () async {
                      final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(
                          initialText: productManager.search,
                        ),
                      );
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constrains.biggest.width,
                      child: Center(
                        child: Text(
                          '${productManager.search}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              return productManager.search.isEmpty
                  ? IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(),
                        );
                        if (search != null) {
                          productManager.search = search;
                        }
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        productManager.search = '';
                      },
                    );
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductsListTile(
                product: filteredProducts[index],
              );
            },
          );
        },
      ),
    );
  }
}
