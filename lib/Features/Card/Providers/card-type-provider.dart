
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

