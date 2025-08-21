import 'package:flutter/cupertino.dart';

import '../../../Firebase/DataBase/user_cart.dart';

class CartItemDeleteProvider extends ChangeNotifier{
  remover(productId, context){
    Cart.removeCard(productId, context);
    notifyListeners();
  }
}