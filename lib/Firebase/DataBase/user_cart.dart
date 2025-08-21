import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:provider/provider.dart';
import '../../Providers/bottom_buttom_provider.dart';

final dataBaseRef = FirebaseFirestore.instance.collection('Cart');
final _auth = FirebaseAuth.instance;



//! Cart
//?        |===>> Id = 1 
// !                      |===>> CartItem
// ?                                 |===>> ProductId
//*                                               |===>> field [
//*                                                              quantity ,
//*                                                              name ,
//*                                                              price ,

// *                                                  ]
                      


class Cart {
  static addCart(
    context, {
    required String productId,
    required int qty,
    required int price,
    required String name,
    required String type,
    required String image,
  }) {
    dataBaseRef
        .doc(_auth.currentUser!.uid)
        .collection('CartItems')
        .doc(productId)
        .set({
      'ProductId': productId,
      'QTY': qty,
      'Name': name,
      'Type': type,
      'Price': price,
      'Image': image,
    }).then((_) {
      //!have to update the  toast message according to my old medicine care app
      Provider.of<BottomButtomProvider>(context, listen: false).endloading();
      Toastmassage.SuccessToast(context, 'Added to Cart');
    }).onError((error, stackTrace) {
      Provider.of<BottomButtomProvider>(context, listen: false).endloading();
      Toastmassage.ErrorToast(context, error);
    });
  }

  static removeCard(String productId, BuildContext context) {
    dataBaseRef
        .doc(_auth.currentUser!.uid)
        .collection('CartItems')
        .doc(productId)
        .delete()
        .then((_) {
      Toastmassage.SuccessToast(context, 'Removed from Cart');
    }).onError((error, stackTrace) {
      Toastmassage.ErrorToast(context, error);
    });
  }

  static increaseCount(String productId, int quantity, BuildContext context) {
    int newQuantity = quantity;
    dataBaseRef 
        .doc(_auth.currentUser!.uid)
        .collection('CartItems')
        .doc(productId)
        .update({
      'QTY': newQuantity,
    }).then((_) {
      Toastmassage.SuccessToast(context, 'Increased');
    }).onError((error, stackTrace) {
      Toastmassage.ErrorToast(context, error);
    });
  }

  static decreaseCount(String productId, int quantity, BuildContext context) {
    int newQuantity = quantity;
    dataBaseRef
        .doc(_auth.currentUser!.uid)
        .collection('CartItems')
        .doc(productId)
        .update({
      'QTY': newQuantity,
    }).then((_) {
      Toastmassage.SuccessToast(context, 'Decreased');
    }).onError((error, stackTrace) {
      Toastmassage.ErrorToast(context, error);
    });
  }

//!  calling this function in the confirmation screen :
  static Future<void> clearCart(context) async {
    try {
      final userId = _auth.currentUser!.uid;
      final cartItemsRef = dataBaseRef.doc(userId).collection('CartItems');

      final snapshot = await cartItemsRef.get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      await dataBaseRef.doc(userId).delete();

      Toastmassage.SuccessToast(context, 'Checkout Successful');
    } catch (e) {
      Toastmassage.ErrorToast(context, e.toString());
    }
  }
}
