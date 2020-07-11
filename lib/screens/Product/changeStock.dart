import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/models/Product.dart';
import 'package:stockmanager/services/firebaseServiceProvider.dart';

class UpdateStock extends StatefulWidget {
  Product product;
  int stock = 0;

  UpdateStock({this.product}) {
    this.stock = this.product.stock;
  }

  @override
  _UpdateStockState createState() => _UpdateStockState();
}

//image
//name
//price
//editable stock

class _UpdateStockState extends State<UpdateStock> {
  final FirebaseProvider _firebaseProvider = FirebaseProvider();
  void AddToStock(int num) {
    if (widget.stock + num > 0) {
      setState(() {
        widget.stock = widget.stock + num;
      });
    } else {
      setState(() {
        widget.stock = 0;
      });
    }
  }

  Widget GetButtonTheme(int num) {
    return ButtonTheme(
      minWidth: 60.0,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          AddToStock(num);
        },
        child: Text(num > 0 ? "+$num" : "$num"),
      ),
    );
  }

  Widget specialCharsPanel() {
    return Wrap(
      spacing: 2,
      direction: Axis.horizontal,
      children: <Widget>[
        GetButtonTheme(-10),
        GetButtonTheme(-1),
        ButtonTheme(
          minWidth: 40.0,
          child: FlatButton(
            color: Colors.white,
            onPressed: () {},
            child: Text(
              "${widget.stock}",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
        ),
        GetButtonTheme(1),
        GetButtonTheme(10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Product Info:",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: NetworkImage(widget.product.imgSrc),
              height: 200,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Text(
              "Product Name : ${widget.product.name}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              "Price : ${widget.product.price}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Update Stock",
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        specialCharsPanel(),
        RaisedButton(
          onPressed: () {
            widget.product.stock = widget.stock;
            _firebaseProvider.updateProductData(widget.product);
            Navigator.of(context).pop();
          },
          child: Text(
            'Confirm',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
        )
      ],
    );
  }
}
