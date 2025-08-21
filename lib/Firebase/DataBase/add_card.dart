

// ================================
// 4. FIREBASE ADD CARD FUNCTION (Same as old)
// ================================
// File: firebase/database/add_card.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:provider/provider.dart';
import '../../Providers/bottom_buttom_provider.dart';
import '../../Resources/Navigators/navigators.dart';
import '../../Resources/Paths/imports.dart';

final databaseRef = FirebaseFirestore.instance.collection('User');
final _auth = FirebaseAuth.instance;

addCard({
  required String ownername,
  required String cardNo,
  required String exp,
  required String cvv,
  required String type,
  required BuildContext context,
}) {
  // Validation: check for empty fields
  if (ownername.trim().isEmpty ||
      cardNo.trim().isEmpty ||
      exp.trim().isEmpty ||
      cvv.trim().isEmpty ||
      type.trim().isEmpty) {
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
    Toastmassage.ErrorToast(context,'All fields are required.');
    return;
  }

  final cartMap = {
    'name': ownername,
    'cardNo': cardNo,
    'exp': exp,
    'cvv': cvv,
    'cardType': type,
  };

  List cartDataList = [cartMap];

  databaseRef.doc(_auth.currentUser!.uid).update({
    'Cards': FieldValue.arrayUnion(cartDataList),
  }).then((_) {
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
    Toastmassage.SuccessToast(context,'Card added');
    NavigatorPop(context);
  }).onError((error, stackTrace) {
    Provider.of<BottomButtomProvider>(context, listen: false).endloading();
    Toastmassage.ErrorToast(context,error.toString());
  });
}
