import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//!  Getting UserData : 

Future<DocumentSnapshot<Map<String, dynamic>>> getUserdataFun ()async{
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final userData= FirebaseFirestore.instance.collection('User').doc(uid);
  final getData =userData.get();
  return getData;
}
