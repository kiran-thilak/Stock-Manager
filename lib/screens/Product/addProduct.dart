import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/models/Product.dart';
import 'package:stockmanager/services/firebaseServiceProvider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseProvider _firebaseProvider = FirebaseProvider();
  Product _product = Product(id: '',name: '',imgSrc: '',price: 0.0,stock: 0, isDeleted: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                TextFormField(
                  decoration: InputDecoration(hintText: 'Product Name'),
                  validator: (value) {
                    return value.isEmpty || value == '0'  ? 'Please enter some text' : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _product.name = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Image Upload Path'),
                  validator: (value) {
                    return value.isEmpty || value == '0'  ? 'Please enter some text' : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _product.imgSrc = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Price'),
                  validator: (value) {
                    return value.isEmpty ? 'Please enter Product Price' : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _product.price = double.parse(value);
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Stock'),
                  validator: (value) {
                    return value.isEmpty ? 'Please enter Stock count' : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _product.stock = int.parse(value);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () async {
                      if(_formKey.currentState.validate())
                        {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                        dynamic result = await _firebaseProvider.addProductData(_product);
                        if( result!= null) {
                          print(result.documentID);
                        }
                        }
                      Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                )

              ],
            )),
      ),
    );
  }
}
