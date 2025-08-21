import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier{
    int _selectedindex =0;
 int get selectedIndex => _selectedindex;
  imageChange(index){
    _selectedindex = index;
    print(_selectedindex);
    notifyListeners();
  }
}