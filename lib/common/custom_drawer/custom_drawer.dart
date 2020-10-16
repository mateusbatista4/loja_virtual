import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              
              gradient: LinearGradient( 
              colors: [
                const Color.fromARGB(255, 203, 236, 241),
                Colors.grey[100]
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              
              )
            ),
          ),
          ListView(children: <Widget>[
            CustomDrawerHeader(),
            Divider(),
            DrawerTile(
              myIcon: Icons.home,
              text: "Inicio",
              pageNumber: 0,
            ),
            DrawerTile(
              myIcon: Icons.list,
              text: "Produtos",
              pageNumber: 1,
            ),
            DrawerTile(
              myIcon: Icons.playlist_add_check,
              text: "Meus Pedidos",
              pageNumber: 2,
            ),
            DrawerTile(
              myIcon: Icons.location_on,
              text: "Lojas",
              pageNumber: 3,
            ),
          ]),
        ],
      ),
    );
  }
}
