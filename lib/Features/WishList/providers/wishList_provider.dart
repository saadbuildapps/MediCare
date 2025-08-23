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
 

  removeFromWishList(ProductID, context) {

    UserWishlist.removeWishList(ProductID, context);
    changeColor();
    notifyListeners();
  }
}
