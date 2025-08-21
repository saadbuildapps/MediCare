import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laza/Firebase/DataBase/user_cart.dart';


class CartProductcountProvider extends ChangeNotifier{
  final int _itemCount = 1;
  final List<int> _listitemcount = [];
  int get itemCount => _itemCount;

  final dataBaseRef = FirebaseFirestore.instance.collection('User');
  final _auth = FirebaseAuth.instance;

  increaseCount( {productId, quantity, context}){

Cart.increaseCount(productId, quantity, context);
    notifyListeners();
  }


  decreaseCount( {productId, quantity, context}){
    if(quantity >1 ){
     Cart.decreaseCount(productId, quantity, context, );
    notifyListeners();
  }
  }}
