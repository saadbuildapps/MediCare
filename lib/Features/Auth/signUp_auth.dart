
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Features/Auth/AuthDatabase/user_data.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:laza/Features/Auth/Screeens/auth_screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/bottom_buttom_provider.dart';

final _auth = FirebaseAuth.instance;
//! Autheticationing process :  user creating with email and password:
//!   and passing data to the User data from signIn screen
signUp_auth(emailController, passwordController ,context ,nameController, image, val)  {
  _auth.createUserWithEmailAndPassword(email: emailController, password: passwordController).then(
      (_)async{
        var uId = _auth.currentUser?.uid;
        Toastmassage.SuccessToast(context,'Account Created SuccessFully');
        UserData(nameController, emailController, image, context);
        NavigatorTo(context, const LoginScreen());
        Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
        SharedPreferences sp = await  SharedPreferences.getInstance();
        sp.setBool('rememberMe', val);
return uId;
      }
  ).onError((error, stackTrace){
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
Toastmassage.ErrorToast(context,error.toString());
return null;
  });
}