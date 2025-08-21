import 'package:flutter/foundation.dart';

class CardFormProvider extends ChangeNotifier {
  String _rawCardNumber = '';
  String _cardholderName = '';
  String _expiryDate = '';
  String _cvv = '';
  bool _hasAnimatedOnce = false;
  
  // Getters
  String get rawCardNumber => _rawCardNumber;
  String get cardholderName => _cardholderName;
  String get expiryDate => _expiryDate;
  String get cvv => _cvv;
  bool get hasAnimatedOnce => _hasAnimatedOnce;
  
  // Setters with notify
  void setCardNumber(String value) {
    _rawCardNumber = value;
    notifyListeners();
  }
  
  void setCardholderName(String value) {
    _cardholderName = value;
    notifyListeners();
  }
  
  void setCVV(String value) {
    _cvv = value;
    notifyListeners();
  }
  
  void setAnimated() {
    _hasAnimatedOnce = true;
    notifyListeners();
  }
  
  // Format card number with masking like GetX version
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
  
  // Format expiry date
  void formatExpiryDate(String value) {
    if (value.length == 2 && !value.contains('/')) {
      _expiryDate = '$value/';
    } else {
      _expiryDate = value;
    }
    notifyListeners();
  }
  
  // Validation
  bool isValid() {
    return _rawCardNumber.length >= 14 &&
        _cardholderName.isNotEmpty &&
        _expiryDate.length == 5 &&
        _cvv.length == 3;
  }
  
  // Clear form
  void clearForm() {
    _rawCardNumber = '';
    _cardholderName = '';
    _expiryDate = '';
    _cvv = '';
    notifyListeners();
  }
}