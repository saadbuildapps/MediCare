// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:laza/Providers/bottom_buttom_provider.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Firebase/Auth/Screeens/login_screen.dart';
// import 'package:provider/provider.dart';
// import '../../Resources/NotificationMassage/ToastMassage.dart';

// final _auth = FirebaseAuth.instance;
// forgetPasswordAuth(email, context){
//   _auth.sendPasswordResetEmail(email: email).then(
//           (_){
//         Toastmassage.SuccessToast('Email has been Sent');
//         Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
//         NavigatorToReplace(context, const LoginScreen());

//       }
//   ).onError((error, stackTrace){
//     Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
//     Toastmassage.ErrorToast(error.toString());
//   });
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Features/Auth/Screeens/auth_screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../../Resources/NotificationMassage/ToastMassage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> forgetPasswordAuth(String email, context) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    Toastmassage.SuccessToast(context,'Password reset email has been sent!');
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
    NavigatorToReplace(context, const LoginScreen());
  } on FirebaseAuthException catch (e) {
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
    if (e.code == 'user-not-found') {
      Toastmassage.ErrorToast(context,'No user found with this email.');
    } else if (e.code == 'invalid-email') {
      Toastmassage.ErrorToast( context,'Invalid email address.');
    } else {
      Toastmassage.ErrorToast(context,e.message ?? 'Something went wrong');
    }
  } catch (e) {
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
    Toastmassage.ErrorToast(context,e.toString());
  }
}
