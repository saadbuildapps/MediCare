
import 'package:flutter/foundation.dart';

import '../../../Firebase/DataBase/address.dart';

class Addressprovider extends ChangeNotifier{
  String _status = 'NotAdded';
  String get status => _status;

  address(name,city,country,phone,address,context){
    addAddress(name,city,country,phone,address,context);
    _status = 'Added';
    notifyListeners();
  }



}