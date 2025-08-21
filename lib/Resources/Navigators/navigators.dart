import 'package:flutter/material.dart';

NavigatorTo(context ,screen){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>screen));
}
NavigatorToReplace(context ,screen){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>screen));
}
NavigatorPop(context ){
  Navigator.of(context).pop(context);
}