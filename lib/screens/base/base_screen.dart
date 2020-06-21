import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController myController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(myController),
      child: PageView(
        controller: myController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text("Home1"),
            ),
          ),
          ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text("Home3"),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text("Home4"),
            ),
          ),
          
        ],
      ),
    );
  }
}
