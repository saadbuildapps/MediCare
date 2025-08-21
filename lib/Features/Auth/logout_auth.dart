import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../Resources/Navigators/navigators.dart';
import '../../Resources/NotificationMassage/ToastMassage.dart';
import 'Screeens/auth_screens/login_screen.dart';

final _auth = FirebaseAuth.instance;

logoutAuth(context){
  _auth.signOut().then(
          (_)async{
        Toastmassage.SuccessToast(context,'LogOut SuccessFully');
        NavigatorToReplace(context, const LoginScreen());
        SharedPreferences sp = await  SharedPreferences.getInstance();
        sp.remove('rememberMe');

      }
  ).onError((error, stackTrace){
    Toastmassage.ErrorToast(context,error.toString());
  });
}