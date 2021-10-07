import 'package:flutter/material.dart';
import 'package:shop_app2/presentation_layer/widgets/gridView-items.dart';




class ItemsScreen extends StatelessWidget {
 // const ItemsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridViewItems()
    );
  }
}
