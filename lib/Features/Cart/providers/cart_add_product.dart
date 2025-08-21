import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laza/Models/cart_item_model.dart';
import '../../../Firebase/DataBase/user_cart.dart';

class CartAddProductProvider with ChangeNotifier {
  List<CartItemModel> _cartList = [];

  List<CartItemModel> get cartdata => _cartList;

  Future<void> getCart() async {
    List<CartItemModel> cartDataList = [];
    QuerySnapshot<Map<String, dynamic>> dataRef = await FirebaseFirestore
        .instance
        .collection('Cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('CartItems')
        .get();

    cartDataList = dataRef.docs.map((element) {
      return CartItemModel(
        productId: element.get('ProductId'),
        quantity: element.get('QTY'),
        image: element.get('Image'),
        name: element.get('Name'),
        type: element.get('Type'),
        price: element.get('Price'),
      );
    }).toList();

    _cartList = cartDataList;
    notifyListeners();
  }

  void addToCart(
      context, {
        required String productId,
        required int qty,
        required int price,
        required String name,
        required String type,
        required String image,
      }) {
    Cart.addCart(
      context,
      productId: productId,
      qty: qty,
      price: price,
      name: name,
      type: type,
      image: image,
    );
    _cartList.add(CartItemModel(
      productId: productId,
      quantity: qty,
      price: price,
      name: name,
      type: type,
      image: image,
    ));
    notifyListeners();
  }

  void increment(String productId, BuildContext context) {
    final index = _cartList.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      _cartList[index] = CartItemModel(
        productId: _cartList[index].productId,
        quantity: _cartList[index].quantity + 1,
        price: _cartList[index].price,
        name: _cartList[index].name,
        type: _cartList[index].type,
        image: _cartList[index].image,
      );
      Cart.increaseCount(productId, _cartList[index].quantity, context);
      notifyListeners();
    }
  }

  void decrement(String productId,   BuildContext context) {
    final index = _cartList.indexWhere((item) => item.productId == productId);
    if (index != -1 && _cartList[index].quantity > 1) {
      _cartList[index] = CartItemModel(
        productId: _cartList[index].productId,
        quantity: _cartList[index].quantity - 1,
        price: _cartList[index].price,
        name: _cartList[index].name,
        type: _cartList[index].type,
        image: _cartList[index].image,
      );
      Cart.decreaseCount(productId, _cartList[index].quantity, context);
      notifyListeners();
    }
  }

  void removeFromCart(String productId, BuildContext context) {
    _cartList.removeWhere((item) => item.productId == productId);
    Cart.removeCard(productId,context);
    notifyListeners();
  }

  double cartSubTotal() {
    return _cartList.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }
}