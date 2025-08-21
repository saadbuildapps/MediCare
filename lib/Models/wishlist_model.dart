
class WishlistModel{
 final String productId;
 final String Producttype;
 final String Productname;
 final List ProductimagePath;
 final List Size;
 final String Productdescription;
 final List ProductReviews;
 final int Productprice;
 final bool Status;


  WishlistModel({required this.Status, required this.Producttype, required this.Productname, required this.ProductimagePath, required this.Size, required this.Productdescription, required this.ProductReviews, required this.Productprice,required this.productId});
}


// List id = [];