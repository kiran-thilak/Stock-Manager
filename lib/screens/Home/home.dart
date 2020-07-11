
import 'package:flutter/material.dart';
import 'package:stockmanager/models/Product.dart';
import 'package:stockmanager/screens/Product/addProduct.dart';
import 'package:stockmanager/screens/Products/listProduct.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/services/firebaseServiceProvider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
      value: FirebaseProvider().products,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Text('Stock Manger'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: (){  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeAddProduct() )); }, icon: Icon(Icons.add,color: Colors.white,), label: Text('Add', style: TextStyle(color: Colors.white),))
          ],
        ),
        //body: AddProduct(),
        body: ProductList(),
      ),
    );
  }
}

class HomeAddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Text('Stock Manger'),
          elevation: 0.0,
          actions: <Widget>[

          ],
        ),
        body: AddProduct(),

      );

  }
}
