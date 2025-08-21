//
//
// import 'dart:math';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:laza/Models/review_model.dart';
//
// class ReviewProvider with ChangeNotifier{
//   List reviewList = [];
//
//   Future getReviews() async {
//
//     List<ReviewModel> reviewDataList = [];
//    QuerySnapshot<Map<String, dynamic>> dataRef = await FirebaseFirestore
//         .instance.collection('MedCareProducts').get();
//     dataRef.docs.forEach((element) {
//       ReviewModel modaldata = ReviewModel(
//           reviews: element.get('reviews'));
//       reviewDataList.add(modaldata);
//     });
//     reviewList = reviewDataList;
//     print('Review list is $reviewList');
//     notifyListeners();
//   }
//
//
//   Future () async {
//
//     List<ReviewModel> reviewDataList = [];
//
//     reviewList = reviewDataList;
//     print('Review list is $reviewList');
//     notifyListeners();
//   }
//
//   get reviewdata {
//     print(reviewList);
//     return reviewList;
//   }
//
//
//   cartSubTotal(){
//     double  subTotal =0.0;
//     reviewList.forEach((element){
//
//       subTotal += element.price * element.quantity;
//
//     });
//     return subTotal;
//   }
// }
//
