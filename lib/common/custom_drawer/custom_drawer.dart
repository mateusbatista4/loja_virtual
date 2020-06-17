import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerTile(myIcon: Icons.home,text: "Inicio",pageNumber: 0,),
          DrawerTile(myIcon: Icons.list,text: "Produtos",pageNumber: 1,),
          DrawerTile(myIcon: Icons.playlist_add_check,text: "Meus Pedidos",pageNumber: 2,),
          DrawerTile(myIcon: Icons.location_on,text: "Lojas",pageNumber: 3,),
        ]
      ),
    );
  }
}