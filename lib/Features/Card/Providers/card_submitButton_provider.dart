
// ================================
// 5. SUBMIT BUTTON PROVIDER
// ================================
// File: providers/submit_button_provider.dart
import 'package:flutter/foundation.dart';

class SubmitButtonProvider extends ChangeNotifier {
  double _fillPercent = 0.0;
  bool _isDone = false;
  bool _isSubmitting = false;
  
  double get fillPercent => _fillPercent;
  bool get isDone => _isDone;
  bool get isSubmitting => _isSubmitting;
  
  Future<void> startAnimation(Function onComplete) async {
    if (_isSubmitting) return;

    _isSubmitting = true;
    _fillPercent = 0;
    _isDone = false;
    notifyListeners();

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      _fillPercent = i / 100;
      notifyListeners();
    }

    _isDone = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));

    onComplete();

    // Reset so button can be used again
    await Future.delayed(const Duration(milliseconds: 500));
    _fillPercent = 0;
    _isDone = false;
    _isSubmitting = false;
    notifyListeners();
  }
}

