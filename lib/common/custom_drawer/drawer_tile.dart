import 'package:flutter/material.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({Key key, this.myIcon, this.text, this.pageNumber})
      : super(key: key);
  final IconData myIcon;
  final String text;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    int current = context.watch<PageManager>().current;
    final Color primColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(pageNumber);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                myIcon,
                size: 32,
                color: current == pageNumber ? primColor : Colors.grey[600],
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: current == pageNumber ? primColor : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
