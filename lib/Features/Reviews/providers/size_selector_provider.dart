import 'package:flutter/foundation.dart';

class SizeSelectorProvider extends  ChangeNotifier{
int _selectedIndex =0 ;
  int get selectedIndex => _selectedIndex;
  selectedSize(index){
    _selectedIndex =index;
    notifyListeners();
  }
}