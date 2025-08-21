import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';

final databaseRef = FirebaseFirestore.instance.collection('MedCareProducts');
/// Get current user data from Firestore
Future<DocumentSnapshot<Map<String, dynamic>>> getUserDataFun() async {
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('User not authenticated');
    }
    
    final userData = FirebaseFirestore.instance.collection('User').doc(uid);
    return await userData.get();
  } catch (e) {
    throw Exception('Failed to get user data: $e');
  }
}

Future<String> getUserImageUrl() async {
  try {
    final userData = await getUserDataFun();
    if (userData.exists && userData.data() != null) {
      final data = userData.data()!;
      return data['profileImage']?.toString() ?? '';
    }
    return '';
  } catch (e) {
    print('Error getting user image URL: $e');
    return '';
  }
}

addReview(productId, name, review, rating, context) async {
 String imageUrl = await getUserImageUrl();
  final mapData = {
    'image': imageUrl,
    'name': name,
    'review': review,
    'rating': rating,
    'time':
        '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}'
  };
  final ListData = [mapData];

  await databaseRef
      .doc(productId.toString())
      .update({'reviews': FieldValue.arrayUnion(ListData)}).then((_) {
    Toastmassage.SuccessToast(context,'Review add success');
    NavigatorPop(context);
  }).onError((error, stackTrace) {
    Toastmassage.ErrorToast(context,error);
  });
}
