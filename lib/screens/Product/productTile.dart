import 'package:stockmanager/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/screens/Product/changeStock.dart';

class ProductTile extends StatelessWidget {
  final Product oProduct;
  ProductTile({this.oProduct});



  @override
  Widget build(BuildContext context) {

    void _showUpdateProduct() {
      print('called function with stock ${oProduct.stock}');
      showModalBottomSheet<dynamic>(context: context, builder: (context) {

        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: UpdateStock(product: oProduct),
          height: MediaQuery.of(context).size.height * 0.70,
        );
      }, isScrollControlled: true, );
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Image.network(oProduct.imgSrc),
          title: Text(oProduct.name),
          onTap: (){ _showUpdateProduct(); },
          subtitle: Row(
            children: <Widget>[
              Text('Price : ${oProduct.price}'),
              SizedBox(width: 10,),
              Text('Stock : ${oProduct.stock}')
            ],
          ),
        ),

      ),
    );
  }
}
