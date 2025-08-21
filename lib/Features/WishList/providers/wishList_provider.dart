import 'package:flutter/foundation.dart';
import 'package:laza/Firebase/DataBase/user_wishList.dart';

class WishlistProvider extends ChangeNotifier {
  bool _statusAdded = false;
  bool get status => _statusAdded;

  changeColor(){
    _statusAdded = !_statusAdded;
    notifyListeners();
}



  addToWishlist({required String productId,required String  Producttype,required String Productname
    ,required String Productbrand,required List ProductimagePath,required List Size,
    required String  Productdescription,required List ProductReviews,required int Productprice}) {
    UserWishlist.addWishList(
      productId: productId,
      Productbrand: Productbrand,
      Productdescription: Productdescription,
      ProductimagePath: ProductimagePath,
      Productname: Productname,
      Productprice: Productprice,
      ProductReviews: ProductReviews,
      Producttype: Producttype,
      Size: Size,
    );
  changeColor();
    notifyListeners();
  }
  //
  //
  // List<WishlistModel> wishlist = [];
  //
  // Future getWishlist() async {
  //
  //   List<WishlistModel> wishDataList = [];
  //   QuerySnapshot<Map<String, dynamic>> dataRef = await FirebaseFirestore.instance.collection('Wishlist')
  //       .doc(FirebaseAuth.instance.currentUser!.uid).collection('WishlistItem')
  //       .get();
  //
  //   dataRef.docs.forEach((element) {
  //     WishlistModel modaldata = WishlistModel(
  //       Producttype: element.get('ProductId'),
  //       Productname:element.get('ProductId'),
  //       ProductimagePath:element.get('ProductId'),
  //       Size:element.get('ProductId'),Productdescription: element.get('ProductId'),
  //       ProductReviews:element.get('ProductId'), Productprice: element.get('ProductId'),
  //       productId: element.get('ProductId'),
  //       Status: element.get('Status')
  //     );
  //     wishDataList.add(modaldata);
  //   });
  //   wishlist = wishDataList;
  //   notifyListeners();
  // }
  //
  // get wishlistdata {
  //   print('data');
  //   return wishlist;
  // }
  //




  removeFromWishList(ProductID, context) {

    UserWishlist.removeWishList(ProductID, context);
    changeColor();
    notifyListeners();
  }
}
