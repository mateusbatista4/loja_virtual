import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({Key key, this.size}) : super(key: key);

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color ;
    if(!size.hasStock) color = Colors.red.withAlpha(50);
    else if(selected) color = Theme.of(context).primaryColor;
    else color = Colors.grey.withAlpha(110);

    return GestureDetector(
      onTap: () {
        if(size.hasStock){
          product.selectedSize = size;
        }
      },
          child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: color,
              padding: EdgeInsets.symmetric(vertical:4,horizontal:8) ,
              child: Text(
                size.name,
                style: TextStyle(color:Colors.white),
              ),
            ),
            
            Container(
              
              padding: EdgeInsets.symmetric(vertical:4,horizontal:8) ,
              child: Text(
               'R\$${size.price}',
               style: TextStyle(color:color),
              ),
            )
          ],
        ),
      ),
    );
  }
}