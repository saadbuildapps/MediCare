import 'package:laza/Resources/Paths/imports.dart';

class TimerProvider extends ChangeNotifier{

  int _time =20;
  int get time => _time;

  decrement(){
    if(_time >=1){
      _time =  _time- 1;
    }
    notifyListeners();
  }

}