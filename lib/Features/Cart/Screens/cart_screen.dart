// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:laza/Providers/cart_add_product.dart';
// import 'package:laza/Models/cart_item_model.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Resources/Widgets/cart_item.dart';
// import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
// import 'package:laza/Veiw/shoping_screen/address_screen.dart';
// import 'package:laza/Veiw/shoping_screen/confrim_order_screen.dart';
// import 'package:laza/Card/Screens/payment_screen.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';

// import '../../Firebase/DataBase/user_cart.dart';
// import '../../Resources/MediaQuery/media_query.dart';
// import '../../Resources/Paths/AssetsPath.dart';
// import '../../Resources/Paths/imports.dart';
// import '../../Resources/NavigationBar/nav_bar.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
//   final auth = FirebaseAuth.instance;
//   final userId = auth.currentUser!.uid;
//   return FirebaseFirestore.instance.collection('User').doc(userId).get();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final w = getScreenSize(context).width / 375;
//     final h = getScreenSize(context).height / 812;

//     final cartProvider =
//         Provider.of<CartAddProductProvider>(context, listen: false);
//     cartProvider.getCart();

//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.grey.shade50,
//           appBar: appBar(context, title: 'Shopping Cart'),
//           body: Consumer<CartAddProductProvider>(
//               builder: (context, cartValue, _) {
//             return cartValue.cartdata.isNotEmpty
//                 ? RefreshIndicator(
//                     onRefresh: () async {
//                       setState(() => getUserData());
//                       await Future.delayed(const Duration(seconds: 2));
//                     },
//                     child:
//                         FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                       future: getUserData(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(
//                             child: Container(
//                               padding: const EdgeInsets.all(40),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.05),
//                                     blurRadius: 20,
//                                     offset: const Offset(0, 10),
//                                   ),
//                                 ],
//                               ),
//                               child: LoadingAnimationWidget.stretchedDots(
//                                 color: MyColor.purple,
//                                 size: 60,
//                               ),
//                             ),
//                           ).animate().fade(duration: 400.ms).scale();
//                         }

//                         if (snapshot.hasError) {
//                           return Center(
//                             child: Container(
//                               padding: const EdgeInsets.all(30),
//                               margin: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(color: Colors.red.shade100),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.red.withOpacity(0.1),
//                                     blurRadius: 20,
//                                     offset: const Offset(0, 10),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(Icons.error_outline,
//                                       size: 50, color: Colors.red.shade300),
//                                   const SizedBox(height: 15),
//                                   const Text(
//                                     'Something went wrong',
//                                     style: TextStyle(
//                                       color: MyColor.textBlack,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 18,
//                                       fontFamily: 'Inter',
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     'Please try again later',
//                                     style: TextStyle(
//                                       color: Colors.grey.shade600,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14,
//                                       fontFamily: 'Inter',
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ).animate().fade(duration: 400.ms);
//                         }

//                         final userData = snapshot.data!.data() ?? {};
//                         final addressDetail = userData['AddressDetail'];
//                         final cards = userData['Cards'];

//                         return SingleChildScrollView(
//                           physics: const BouncingScrollPhysics(),
//                           child: Column(
//                             children: [
//                               // Cart Items Section
//                               Container(
//                                 margin: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 20,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           20, 20, 20, 10),
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             padding: const EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               color: MyColor.purple
//                                                   .withOpacity(0.1),
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: const Icon(
//                                               Icons.shopping_bag_outlined,
//                                               color: MyColor.purple,
//                                               size: 20,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 12),
//                                           const Text(
//                                             'Cart Items',
//                                             style: TextStyle(
//                                               color: MyColor.textBlack,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 18,
//                                               fontFamily: 'Inter',
//                                             ),
//                                           ),
//                                           const Spacer(),
//                                           Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 12, vertical: 6),
//                                             decoration: BoxDecoration(
//                                               color: MyColor.purple
//                                                   .withOpacity(0.1),
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             child: Text(
//                                               '${cartValue.cartdata.length} items',
//                                               style: const TextStyle(
//                                                 color: MyColor.purple,
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 12,
//                                                 fontFamily: 'Inter',
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Consumer<CartAddProductProvider>(
//                                       builder: (context, provider, _) {
//                                         final List<CartItemModel> data =
//                                             provider.cartdata;
//                                         return ListView.builder(
//                                           itemCount: data.length,
//                                           shrinkWrap: true,
//                                           physics:
//                                               const NeverScrollableScrollPhysics(),
//                                           itemBuilder: (context, index) {
//                                             return Container(
//                                               margin: EdgeInsets.fromLTRB(
//                                                   20,
//                                                   0,
//                                                   20,
//                                                   index == data.length - 1
//                                                       ? 20
//                                                       : 10),
//                                               child: CartItemTile(
//                                                 lable: data[index].name,
//                                                 price:
//                                                     data[index].price.toInt(),
//                                                 quantity: data[index].quantity,
//                                                 onDelete: () {
//                                                   provider.removeFromCart(
//                                                       data[index].productId);
//                                                 },
//                                                 onIncrement: () {
//                                                   provider.increment(
//                                                       data[index].productId);
//                                                 },
//                                                 onDecrement: () {
//                                                   provider.decrement(
//                                                       data[index].productId);
//                                                 },
//                                                 position: index,
//                                                 projectId:
//                                                     data[index].productId,
//                                                 imagePath: data[index].image,
//                                               ),
//                                             )
//                                                 .animate()
//                                                 .fade(
//                                                     duration: 300.ms,
//                                                     delay: (index * 80).ms)
//                                                 .scale(
//                                                     begin: const Offset(
//                                                         0.95, 0.95),
//                                                     end:
//                                                         const Offset(1.0, 1.0));
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // Delivery Address Section
//                               Container(
//                                 margin:
//                                     const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 20,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(20),
//                                       child: Column(
//                                         children: [
//                                           sectionHeader(
//                                             title: 'Delivery Address',
//                                             icon: Icons.location_on_outlined,
//                                             onTap: () => NavigatorTo(
//                                                 context, const AddressScreen()),
//                                           ),
//                                           const SizedBox(height: 20),
//                                           addressDetail != null
//                                               ? buildAddressSection(
//                                                       addressDetail,
//                                                       w,
//                                                       userData)
//                                                   .animate()
//                                                   .fade(duration: 400.ms)
//                                                   .slideX(begin: 0.1)
//                                               : noDataWidget('No Address Added',
//                                                   Icons.location_off_outlined),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // Payment Method Section
//                               Container(
//                                 margin:
//                                     const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 20,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(20),
//                                   child: Column(
//                                     children: [

//                                       //!

//                                       //!

//                                       //!  have  to add this

//                                       sectionHeader(
//                                         title: 'Payment Method',
//                                         icon: Icons.payment_outlined,
//                                         onTap: () {
//                                           navigatedFrom = '';
//                                           NavigatorTo(
//                                               context, const PaymentScreen());
//                                         },
//                                       ),
//                                       const SizedBox(height: 20),
//                                       cards != null
//                                           ? buildCardSection(cards, w)
//                                               .animate()
//                                               .fade(duration: 400.ms)
//                                               .slideX(begin: -0.1)
//                                           : noDataWidget('No Card Added',
//                                               Icons.credit_card_off_outlined),
//                                     ],
//                                   ),
//                                 ),
//                               ),

//                               // Order Summary Section
//                               Container(
//                                 margin:
//                                     const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       MyColor.purple.withOpacity(0.05),
//                                       Colors.white,
//                                     ],
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                       color: MyColor.purple.withOpacity(0.1)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: MyColor.purple.withOpacity(0.1),
//                                       blurRadius: 20,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(20),
//                                   child: Consumer<CartAddProductProvider>(
//                                     builder: (context, value, _) {
//                                       return buildOrderInfo(value)
//                                           .animate()
//                                           .fade(duration: 400.ms)
//                                           .slideY(begin: 0.1);
//                                     },
//                                   ),
//                                 ),
//                               ),

//                               // Checkout Button
//                               Container(
//                                 margin:
//                                     const EdgeInsets.fromLTRB(20, 0, 20, 30),
//                                 child: Container(
//                                   width: double.infinity,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         MyColor.purple,
//                                         MyColor.purple.withOpacity(0.8)
//                                       ],
//                                       begin: Alignment.centerLeft,
//                                       end: Alignment.centerRight,
//                                     ),
//                                     borderRadius: BorderRadius.circular(20),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: MyColor.purple.withOpacity(0.3),
//                                         blurRadius: 20,
//                                         offset: const Offset(0, 10),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       borderRadius: BorderRadius.circular(20),
//                                       onTap: () {
//                                         NavigatorTo(context,
//                                             const ConfirmOrderScreen());
//                                         // Navigator.pushReplacement(
//                                         //     context,
//                                         //     MaterialPageRoute(
//                                         //         builder: (context) =>
//                                         //             const ConfirmOrderScreen()));
//                                         Cart.clearCart();
//                                       },
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             const Icon(
//                                               Icons
//                                                   .shopping_cart_checkout_outlined,
//                                               color: Colors.white,
//                                               size: 24,
//                                             ),
//                                             const SizedBox(width: 12),
//                                             const Text(
//                                               'Proceed to Checkout',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 16,
//                                                 fontFamily: 'Inter',
//                                               ),
//                                             ),
//                                             const Spacer(),
//                                             Consumer<CartAddProductProvider>(
//                                               builder: (context, value, _) {
//                                                 return Container(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 6),
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white
//                                                         .withOpacity(0.2),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15),
//                                                   ),
//                                                   child: Text(
//                                                     '\$${value.cartSubTotal() + 10}',
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       fontSize: 16,
//                                                       fontFamily: 'Inter',
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ).animate().fade(duration: 500.ms).scale(),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 : Center(
//                     child: Container(
//                       margin: const EdgeInsets.all(40),
//                       padding: const EdgeInsets.all(40),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 30,
//                             offset: const Offset(0, 15),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             height: 200,
//                             width: 200,
//                             child: Lottie.asset(
//                               Animations.emptybox,
//                               repeat: true,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           const Text(
//                             'Your cart is empty',
//                             style: TextStyle(
//                               color: MyColor.textBlack,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                               fontFamily: 'Inter',
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Add some items to get started',
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                               fontFamily: 'Inter',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ).animate().fade(duration: 500.ms).scale();
//           })),
//     );
//   }

//   // --------------------------
//   // Enhanced Reusable Widgets
//   // --------------------------
//   Widget sectionHeader({
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: MyColor.purple.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             icon,
//             color: MyColor.purple,
//             size: 20,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Text(
//           title,
//           style: const TextStyle(
//             color: MyColor.textBlack,
//             fontWeight: FontWeight.w700,
//             fontSize: 18,
//             fontFamily: 'Inter',
//           ),
//         ),
//         const Spacer(),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(10),
//               onTap: onTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 16,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget noDataWidget(String text, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             size: 40,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 12),
//           Text(
//             text,
//             style: TextStyle(
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//               fontSize: 16,
//               fontFamily: 'Inter',
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildAddressSection(
//     List addressDetail, double w, Map<String, dynamic> userData) {
//   // Safety check for empty address list
//   if (addressDetail.isEmpty) {
//     return noDataWidget('No Address Added', Icons.location_off_outlined);
//   }

//   return Container(
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [Colors.green.shade50, Colors.white],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       borderRadius: BorderRadius.circular(15),
//       border: Border.all(color: Colors.green.shade100),
//     ),
//     child: Row(
//       children: [
//         Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               colors: [Colors.green.shade400, Colors.green.shade300],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.green.withOpacity(0.3),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.location_on_rounded,
//             color: Colors.white,
//             size: 24,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 addressDetail[0]['address'] ?? 'No address',
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: const TextStyle(
//                   color: MyColor.textBlack,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   fontFamily: "Inter",
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 addressDetail[0]['city'] ?? 'No city',
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   fontFamily: "Inter",
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.green.shade100,
//             shape: BoxShape.circle,
//           ),
//           child: const Icon(
//             Icons.check_rounded,
//             color: Colors.green,
//             size: 16,
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   Widget buildCardSection(List cards, double w) {
//   if (cards.isEmpty) {
//     return noDataWidget('No Card Added', Icons.credit_card_off_outlined);
//   }

//   // Ensure selectedIndex is valid
//   final safeIndex = (selectedIndex >= 0 && selectedIndex < cards.length)
//       ? selectedIndex
//       : 0;

//   return Container(
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [Colors.blue.shade50, Colors.white],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       borderRadius: BorderRadius.circular(15),
//       border: Border.all(color: Colors.blue.shade100),
//     ),
//     child: Row(
//       children: [
//         Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade400, Colors.blue.shade300],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blue.withOpacity(0.3),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.credit_card_rounded,
//             color: Colors.white,
//             size: 24,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 cards[safeIndex]['cardType'],
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: const TextStyle(
//                   color: MyColor.textBlack,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   fontFamily: "Inter",
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 cards[safeIndex]['cardNo']
//                     .toString()
//                     .replaceRange(0, 6, '••••••'),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   fontFamily: "Inter",
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.blue.shade100,
//             shape: BoxShape.circle,
//           ),
//           child: const Icon(
//             Icons.check_rounded,
//             color: Colors.blue,
//             size: 16,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget buildOrderInfo(CartAddProductProvider value) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: MyColor.purple.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child:  const Icon(
//               Icons.receipt_long_outlined,
//               color: MyColor.purple,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           const Text(
//             'Order Summary',
//             style: TextStyle(
//               color: MyColor.textBlack,
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//               fontFamily: 'Inter',
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: Column(
//           children: [
//             orderRow('Subtotal', '\$${value.cartSubTotal()}', false),
//             const SizedBox(height: 12),
//             orderRow('Shipping', '\$10', false),
//             const SizedBox(height: 12),
//             Container(
//               height: 1,
//               color: Colors.grey.shade200,
//             ),
//             const SizedBox(height: 12),
//             orderRow('Total', '\$${value.cartSubTotal() + 10}', true),
//           ],
//         ),
//       ),
//     ],
//   );
// }

// Widget orderRow(String label, String amount, bool isTotal) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         label,
//         style: TextStyle(
//           color: isTotal ? MyColor.textBlack : Colors.grey.shade600,
//           fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
//           fontSize: isTotal ? 16 : 15,
//           fontFamily: 'Inter',
//         ),
//       ),
//       Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: isTotal ? 12 : 8,
//           vertical: isTotal ? 6 : 4,
//         ),
//         decoration: BoxDecoration(
//           color:
//               isTotal ? MyColor.purple.withOpacity(0.1) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           amount,
//           style: TextStyle(
//             color: isTotal ? MyColor.purple : MyColor.textBlack,
//             fontWeight: FontWeight.w700,
//             fontSize: isTotal ? 18 : 15,
//             fontFamily: 'Inter',
//           ),
//         ),
//       ),
//     ],
//   );
// }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Cart/providers/cart_add_product.dart';
import 'package:laza/Models/cart_item_model.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/cart_item.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Features/Address/address_screen.dart';
import 'package:laza/Features/Confirmation/confrim_order_screen.dart';
import 'package:laza/Features/Card/Screens/payment_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Resources/MediaQuery/media_query.dart';
import '../../../Resources/Paths/AssetsPath.dart';
import '../../../Resources/Paths/imports.dart';
import '../../../Resources/NavigationBar/nav_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
  final auth = FirebaseAuth.instance;
  final userId = auth.currentUser!.uid;
  return FirebaseFirestore.instance.collection('User').doc(userId).get();
}

class _CartScreenState extends State<CartScreen> {
  // Add refresh indicator state
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // Add refresh function
  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Refresh cart data
    final cartProvider =
        Provider.of<CartAddProductProvider>(context, listen: false);
    cartProvider.getCart();

    // Add a small delay for better UX
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });
  }

  // Add validation function
  void _validateAndProceedToCheckout(
      Map<String, dynamic> userData, CartAddProductProvider cartProvider) {
    final addressDetail = userData['AddressDetail'];
    final cards = userData['Cards'];

    // Check if address is available
    if (addressDetail == null || addressDetail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating, // 👈 floating bana deta hai
          backgroundColor: Colors.orange,
          margin: const EdgeInsets.symmetric(
              horizontal: 40, vertical: 20), // 👈 side se space
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 👈 card wali feel
          ),
          content: Row(
            mainAxisSize:
                MainAxisSize.min, // 👈 jitni zaroorat hogi utni width lega
            children: [
              const Icon(Icons.location_off_outlined, color: Colors.white),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Plz add delivery address',
                  style: GoogleFonts.poppins(),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: '',
            textColor: Colors.white,
            onPressed: () {
              NavigatorTo(context, const AddressScreen());
            },
          ),
        ),
      );

      return;
    }

    // Check if card is available
    if (cards == null || cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.credit_card_off_outlined, color: Colors.white),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Plz add payment method ',
                  style: GoogleFonts.poppins(),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: '',
            textColor: Colors.white,
            onPressed: () {
              navigatedFrom = '';
              NavigatorTo(context, const PaymentScreen());
            },
          ),
        ),
      );

      return;
    }

    // If both address and card are available, proceed to checkout
    NavigatorTo(context, const ConfirmOrderScreen());
  }

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width / 375;
    final h = getScreenSize(context).height / 812;

    final cartProvider =
        Provider.of<CartAddProductProvider>(context, listen: false);
    cartProvider.getCart();

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          // appBar: AppBar(
          //   elevation: 4,
          //   title: Text(
          //     'Shopping Cart',
          //     style: GoogleFonts.poppins(),
          //   ),
          //   centerTitle: true,
          // ),
          appBar: buildAppBar(context, 'Shopping Cart'),
          body: Consumer<CartAddProductProvider>(
              builder: (context, cartValue, _) {
            return cartValue.cartdata.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: _onRefresh, // Updated refresh function
                    child:
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            _isRefreshing) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: LoadingAnimationWidget.stretchedDots(
                                color: MyColor.purple,
                                size: 60,
                              ),
                            ),
                          ).animate().fade(duration: 400.ms).scale();
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.red.shade100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.error_outline,
                                      size: 50, color: Colors.red.shade300),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Something went wrong',
                                    style: GoogleFonts.poppins(
                                      color: MyColor.textBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Please try again later',
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animate().fade(duration: 400.ms);
                        }

                        final userData = snapshot.data!.data() ?? {};
                        final addressDetail = userData['AddressDetail'];
                        final cards = userData['Cards'];

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              // Cart Items Section
                              Container(
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: MyColor.purple
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.shopping_bag_outlined,
                                              color: MyColor.purple,
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Cart Items',
                                            style: GoogleFonts.poppins(
                                              color: MyColor.textBlack,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: MyColor.purple
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              '${cartValue.cartdata.length} items',
                                              style: GoogleFonts.poppins(
                                                color: MyColor.purple,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Consumer<CartAddProductProvider>(
                                      builder: (context, provider, _) {
                                        final List<CartItemModel> data =
                                            provider.cartdata;
                                        return ListView.builder(
                                          itemCount: data.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  20,
                                                  0,
                                                  20,
                                                  index == data.length - 1
                                                      ? 20
                                                      : 10),
                                              child: CartItemTile(
                                                lable: data[index].name,
                                                price:
                                                    data[index].price.toInt(),
                                                quantity: data[index].quantity,
                                                onDelete: () {
                                                  provider.removeFromCart(
                                                      data[index].productId,
                                                      context);
                                                },
                                                onIncrement: () {
                                                  provider.increment(
                                                      data[index].productId,
                                                      context);
                                                },
                                                onDecrement: () {
                                                  provider.decrement(
                                                      data[index].productId,
                                                      context);
                                                },
                                                position: index,
                                                projectId:
                                                    data[index].productId,
                                                imagePath: data[index].image,
                                              ),
                                            )
                                                .animate()
                                                .fade(
                                                    duration: 300.ms,
                                                    delay: (index * 80).ms)
                                                .scale(
                                                    begin: const Offset(
                                                        0.95, 0.95),
                                                    end:
                                                        const Offset(1.0, 1.0));
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              // Delivery Address Section
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          sectionHeader(
                                            title: 'Delivery Address',
                                            icon: Icons.location_on_outlined,
                                            onTap: () => NavigatorTo(
                                                context, const AddressScreen()),
                                          ),
                                          const SizedBox(height: 20),
                                          addressDetail != null &&
                                                  addressDetail.isNotEmpty
                                              ? buildAddressSection(
                                                      addressDetail,
                                                      w,
                                                      userData)
                                                  .animate()
                                                  .fade(duration: 400.ms)
                                                  .slideX(begin: 0.1)
                                              : noDataWidget('No Address Added',
                                                  Icons.location_off_outlined),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Payment Method Section
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      sectionHeader(
                                        title: 'Payment Method',
                                        icon: Icons.payment_outlined,
                                        onTap: () {
                                          navigatedFrom = '';
                                          NavigatorTo(
                                              context, const PaymentScreen());
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      cards != null && cards.isNotEmpty
                                          ? buildCardSection(cards, w)
                                              .animate()
                                              .fade(duration: 400.ms)
                                              .slideX(begin: -0.1)
                                          : noDataWidget('No Card Added',
                                              Icons.credit_card_off_outlined),
                                    ],
                                  ),
                                ),
                              ),

                              // Order Summary Section
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      MyColor.purple.withOpacity(0.05),
                                      Colors.white,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: MyColor.purple.withOpacity(0.1)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColor.purple.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Consumer<CartAddProductProvider>(
                                    builder: (context, value, _) {
                                      return buildOrderInfo(value)
                                          .animate()
                                          .fade(duration: 400.ms)
                                          .slideY(begin: 0.1);
                                    },
                                  ),
                                ),
                              ),

                              // Checkout Button
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 30),
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        MyColor.purple,
                                        MyColor.purple.withOpacity(0.8)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: MyColor.purple.withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        // Use validation function
                                        _validateAndProceedToCheckout(
                                            userData, cartValue);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons
                                                  .shopping_cart_checkout_outlined,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              'Proceed to Checkout',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const Spacer(),
                                            Consumer<CartAddProductProvider>(
                                              builder: (context, value, _) {
                                                return Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Text(
                                                    '\$${value.cartSubTotal() + 10}',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ).animate().fade(duration: 500.ms).scale(),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Lottie.asset(
                              Animations.emptybox,
                              repeat: true,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Your cart is empty',
                            style: GoogleFonts.poppins(
                              color: MyColor.textBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add some items to get started',
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fade(duration: 500.ms).scale();
          })),
    );
  }

  // --------------------------
  // Enhanced Reusable Widgets
  // --------------------------
  Widget sectionHeader({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MyColor.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: MyColor.purple,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: MyColor.textBlack,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget noDataWidget(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddressSection(
      List addressDetail, double w, Map<String, dynamic> userData) {
    // Safety check for empty address list
    if (addressDetail.isEmpty) {
      return noDataWidget('No Address Added', Icons.location_off_outlined);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Colors.green.shade400, Colors.green.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addressDetail[0]['address'] ?? 'No address',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    color: MyColor.textBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  addressDetail[0]['city'] ?? 'No city',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.green,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardSection(List cards, double w) {
    if (cards.isEmpty) {
      return noDataWidget('No Card Added', Icons.credit_card_off_outlined);
    }

    // Ensure selectedIndex is valid
    final safeIndex = (selectedIndex >= 0 && selectedIndex < cards.length)
        ? selectedIndex
        : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.credit_card_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cards[safeIndex]['cardType'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: MyColor.textBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cards[safeIndex]['cardNo']
                      .toString()
                      .replaceRange(0, 6, '••••••'),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.blue,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderInfo(CartAddProductProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyColor.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: MyColor.purple,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Order Summary',
              style: GoogleFonts.poppins(
                color: MyColor.textBlack,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              orderRow('Subtotal', '\$${value.cartSubTotal()}', false),
              const SizedBox(height: 12),
              orderRow('Shipping', '\$10', false),
              const SizedBox(height: 12),
              Container(
                height: 1,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 12),
              orderRow('Total', '\$${value.cartSubTotal() + 10}', true),
            ],
          ),
        ),
      ],
    );
  }
}

Widget orderRow(String label, String amount, bool isTotal) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(
          color: isTotal ? MyColor.textBlack : Colors.grey.shade600,
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          fontSize: isTotal ? 16 : 15,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTotal ? 12 : 8,
          vertical: isTotal ? 6 : 4,
        ),
        decoration: BoxDecoration(
          color: isTotal ? MyColor.purple.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          amount,
          style: GoogleFonts.poppins(
            color: isTotal ? MyColor.purple : MyColor.textBlack,
            fontWeight: FontWeight.w700,
            fontSize: isTotal ? 18 : 15,
          ),
        ),
      ),
    ],
  );
}
