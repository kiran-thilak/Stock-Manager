import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/models/Product.dart';
import 'package:stockmanager/screens/Product/productTile.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {

    final products = Provider.of<List<Product>>(context) ?? [];

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        itemBuilder: (context, index) {
      return ProductTile(oProduct: products[index],);
    });
  }
}
