import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:product_app/model/product_model.dart';

class FireStoreProvider {
  final db = FirebaseFirestore.instance.collection('products');

  Future addProduct(ProductModel product) async {
    try {
      final productDB = <String, dynamic>{
        'name': product.name,
        'description': product.description,
        'image': product.image,
        'price': product.price,
        'quantity': product.quantity,
        'measurement': product.measurement
      };
      await db
          .doc(product.name)
          .set(productDB, SetOptions(merge: true))
          .onError((e, _) {
        if (kDebugMode) {
          print('db ref error $e');
          throw e.toString();
        }
      });
    } catch (e) {
      return 'error occured $e';
    }
  }

  Future getProducts({String? val}) async {
    try {
      List<ProductModel> pd = [];
      if (kDebugMode) {
        print('val: $val');
      }
      await db.get().then((doc) {
        for (var element in doc.docs) {
          ProductModel product = ProductModel();
          product.name = element['name'] ?? '';
          product.description = element['description'] ?? '';
          product.image = element['image'] ?? '';
          product.price = element['price'] ?? 0;
          product.quantity = element['quantity'] ?? 0;
          product.measurement = element['measurement'] ?? '';
          pd.add(product);
        }
      }, onError: (e) => 'error occured $e');
      if (val != null) {
        pd = pd.where((element) => element.name!.contains(val)).toList();
      }
      return pd;
    } catch (e) {
      return 'error occured $e';
    }
  }

  Future updateProduct(ProductModel product) async {
    try {
      await db.doc(product.name).update(product.toMap());
    } catch (e) {
      return 'error occured $e';
    }
  }

  Future deleteProduct(String productName) async {
    try {
      await db.doc(productName).delete();
    } catch (e) {
      return 'error occured $e';
    }
  }
}
