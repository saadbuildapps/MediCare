import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import '../../../Models/new_arrival_model.dart';

class HomeScreenProvvider with ChangeNotifier {


  List<NewArrivalModel> productList = [];
  List<NewArrivalModel> filteredProductList = [];


  Future getProduct(context) async {

try{
  List<NewArrivalModel> productDataList = [];
  QuerySnapshot<Map<String, dynamic>> dataRef = await FirebaseFirestore
      .instance.collection('MedCareProducts')
      .get();

  for (var element in dataRef.docs) {
    NewArrivalModel modaldata = NewArrivalModel(
        ProductimagePath: element.get('images'),
        Size: element.get('sizes'),
        Reviews: element.get('reviews'),
        Productdescription: element.get('description'),
        Productname: element.get('name'),
        Productprice: element.get('price'),
        Producttype: element.get('type'),
        ProductId: element.get('ProductId'),
        ProductBrand: element.get('brand'));

    productDataList.add(modaldata);
  }
  productList = productDataList;
  search('');
  print('ProductList $productList');
  notifyListeners(); 
}catch(e){
  Toastmassage.ErrorToast( context ,e.toString());
}

  }

  search(String searchQuery) {
    print('search');

    if (searchQuery.isNotEmpty) {
      filteredProductList = productList.where((product) {
        return product.Productdescription.toLowerCase().contains(searchQuery.toLowerCase()) == true ||
            (product.Productname ?? '').toLowerCase().contains(searchQuery.toLowerCase()) == true   
            ||
            product.ProductBrand.toLowerCase().contains(searchQuery.toLowerCase()) == true;
      }).toList();  // <-- convert Iterable to List here

    } else {
      filteredProductList = productList;
    }

    notifyListeners();

    return filteredProductList;
  }




   get productdata {
    print('data$filteredProductList');
    return filteredProductList;
  }


}