

import '../Resources/Paths/imports.dart';

bool _validpassword =false;
bool _validemail =false;
bool _validloginpassword =false;
bool _validloginemail =false;
bool _validname =false;
bool get valid => _validpassword;

class TextfeildTickProvider extends ChangeNotifier {

  passwordchecker(String controller) {
    if (controller.length <= 5) {
      _validpassword = false;
      notifyListeners();
    } else {
      _validpassword = true;
      notifyListeners();
    }
  }
  passwordchanger() {
    if (_validpassword) {
      return const Text('Strong', style: TextStyle(
          color: MyColor.green,
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w400
      ),);
    } else {
      return const Text('weak',style: TextStyle(
          color: MyColor.red,
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w400
      ),);
    }
  }


  namechecker(String controller) {
    if (controller.length <= 2) {
      _validname = false;
      notifyListeners();
    } else {
      _validname = true;
      notifyListeners();
    }
  }

  namechanger() {
    if (_validname) {
      return  const Icon(Icons.check, color: MyColor.green,);
    } else {
      return const Icon(Icons.close, color: MyColor.red,);
    }
  }

  emailChecker(String controller) {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controller)) {
      _validemail = true;
      notifyListeners();
    } else {
      _validemail = false;
      notifyListeners();
    }
  }

  emailchanger() {
    if (_validemail) {
      return  const Icon(Icons.check, color: MyColor.green,);
    } else {
      return const Icon(Icons.close, color: MyColor.red,);
    }
  }
  emailloginChecker(String controller) {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controller)) {
      _validloginemail = true;
      notifyListeners();
    } else {
      _validloginemail = false;
      notifyListeners();
    }
  }

  emailloginchanger() {
    if (_validloginemail) {
      return  const Icon(Icons.check, color: MyColor.green,);
    } else {
      return const Icon(Icons.close, color: MyColor.red,);
    }
  }


  passwordloginchecker(String controller) {
    if (controller.length <= 5) {
      _validloginpassword = false;
      notifyListeners();
    } else {
      _validloginpassword = true;
      notifyListeners();
    }
  }

  passwordLoginchanger() {
    if (_validloginpassword) {
      return const Text('Strong', style: TextStyle(
        color: MyColor.green,
        fontFamily: 'Inter',
        fontSize: 11,
        fontWeight: FontWeight.w400
      ),);
    } else {
      return const Text('weak',style: TextStyle(
          color: MyColor.red,
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w400
      ),);
    }
  }






}

