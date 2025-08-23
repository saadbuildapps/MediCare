
//!  oldest code  
import 'package:flutter/foundation.dart';

class   BottomButtomProvider with ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

void startloading(){
  _isLoading = true;
  notifyListeners();
}


void endloading(){
  _isLoading = false;
  notifyListeners();
}
}







