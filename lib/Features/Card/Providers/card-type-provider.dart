// import 'package:flutter/foundation.dart';

// class CardTypeProvider extends  ChangeNotifier{
//   int _selectedIndex = 0 ;
//   int get selectedIndex => _selectedIndex;
//   selectedSize(index){
//     _selectedIndex =index;
//     notifyListeners();
//   }
// }


//!

 
// ================================
// 2. CARD TYPE PROVIDER
// ================================
// File: providers/card_type_provider.dart
import 'package:flutter/foundation.dart';

class CardTypeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  
  String _selectedCardType = 'Visa';
  String get selectedCardType => _selectedCardType;
  
  selectedSize(index) {
    _selectedIndex = index;
    // Update card type based on index
    switch (index) {
      case 0:
        _selectedCardType = 'Visa';
        break;
      case 1:
        _selectedCardType = 'MasterCard';
        break;
      case 2:
        _selectedCardType = 'PayPal';
        break;
      default:
        _selectedCardType = 'Visa';
    }
    notifyListeners();
  }
}


 /*
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VisaCardController extends GetxController {
  var rawCardNumber = ''.obs;
  var cardholderName = ''.obs;
  var expiryDate = ''.obs;
  var cvv = ''.obs;
  var selectedCardType = 'Visa'.obs; // Visa, MasterCard, PayPal
  RxBool hasAnimatedOnce = false.obs;

  String formatCardNumber(String number) {
    number = number.replaceAll(RegExp(r'\D'), '');
    number = number.length > 16 ? number.substring(0, 16) : number;
    String masked = '';
    for (int i = 0; i < number.length; i++) {
      if (i < number.length - 4) {
        masked += 'X';
      } else {
        masked += number[i];
      }
    }
    String spaced = '';
    for (int i = 0; i < masked.length; i++) {
      spaced += masked[i];
      if ((i + 1) % 4 == 0 && i != masked.length - 1) {
        spaced += ' ';
      }
    }
    return spaced;
  }

  void formatExpiryDate(String value) {
    if (value.length == 2 && !value.contains('/')) {
      expiryDate.value = '$value/';
    } else {
      expiryDate.value = value;
    }
  }

  bool isValid() {
    return rawCardNumber.value.length >= 14 &&
        cardholderName.value.isNotEmpty &&
        expiryDate.value.length == 5 &&
        cvv.value.length == 3;
  }
}  */