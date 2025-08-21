import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier{
 var _theme = ThemeMode.light;
 get theme => _theme;
 themeChanger(mode){
  (mode)? _theme = ThemeMode.light :_theme =  ThemeMode.dark;
  notifyListeners();
}
}