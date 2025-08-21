
class CartItemModel{
  String productId;
  int quantity;
  final String image;
  final String name;
  final String type;
  final int price;
  CartItemModel( {required this.image, required this.name, required this.type, required this.price,required this.productId,required this.quantity});
}


List<CartItemModel> cartItems =[
];