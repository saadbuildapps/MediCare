import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier{
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  changeQuery(query){
    _controller = query;
    notifyListeners();
}
}