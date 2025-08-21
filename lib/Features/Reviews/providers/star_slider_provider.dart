import 'package:flutter/material.dart';

class StarSliderProvider extends ChangeNotifier{

  double  _value = 0;
  double get value => _value;

  changeValue(newValue){
    _value = newValue;
    notifyListeners();

  }
}