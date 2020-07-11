import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockmanager/models/Product.dart';

class FirebaseProvider {
  //ref to collection
  final CollectionReference _collectionReference =
      Firestore.instance.collection('shop');
  final CollectionReference _transactionReference =
      Firestore.instance.collection('transaction');


  //convert to product
  Product _productFromShopSnapshot(DocumentSnapshot snapshot) {
    return Product(
        id: snapshot.data['id'],
        name: snapshot.data['name'],
        stock: snapshot.data['stock'],
        price: snapshot.data['price'],
        imgSrc: snapshot.data['imgSrc'],
        isDeleted: snapshot.data['isDeleted']);
  }

  List<Product> _productListFromShopSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) {return  Product(
            id: doc.documentID,
            name: doc.data['name'],
            stock: doc.data['stock'],
            price: doc.data['price'],
            imgSrc: doc.data['imgSrc'],
            isDeleted: doc.data['isDeleted']) ; }).where((element) => !element.isDeleted )
        .toList();
  }

  //to get all product
  Stream<List<Product>> get products {
    return _collectionReference.snapshots().map(_productListFromShopSnapshot);
  }

  //to get a product
  Stream<Product> getProduct({id}) {
    return _collectionReference
        .document(id)
        .snapshots()
        .map(_productFromShopSnapshot);
  }

  //update or add a product
  Future<DocumentReference> addProductData(Product product) async {
    DocumentReference result = await _collectionReference.add({
      'name': product.name,
      'stock': product.stock,
      'price': product.price,
      'imgSrc': product.imgSrc,
      'isDeleted': product.isDeleted,
    });
    await _transactionReference.add({
      'type': 'add',
      'reference': result.documentID,
      'updatedTime': FieldValue.serverTimestamp(),
      'name': product.name,
      'stock': product.stock,
      'price': product.price,
      'imgSrc': product.imgSrc
    });

    return result;
  }

  Future<void> updateProductData(Product product) async {
    await _transactionReference.add({
      'type': 'update',
      'reference': product.id,
      'updatedTime': FieldValue.serverTimestamp(),
      'name': product.name,
      'stock': product.stock,
      'price': product.price,
      'imgSrc': product.imgSrc,
    });
    return await _collectionReference.document(product.id.toString()).setData({
      'name': product.name,
      'stock': product.stock,
      'price': product.price,
      'imgSrc': product.imgSrc,
      'isDeleted': product.isDeleted,
    });
  }
}
