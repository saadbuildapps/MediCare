// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:laza/Providers/bottom_buttom_provider.dart';
// import 'package:laza/Providers/cart_add_product.dart';
// import 'package:laza/Providers/product_detail_provider.dart';
// import 'package:laza/Providers/size_selector_provider.dart';
// import 'package:laza/Resources/MediaQuery/media_query.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Resources/Paths/AssetsPath.dart';
// import 'package:laza/Resources/Widgets/review_tile.dart';
// import 'package:laza/Veiw/cart_screen.dart';
// import 'package:laza/Veiw/reviews_screen.dart';
// import 'package:provider/provider.dart';
// import '../Resources/Paths/imports.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final List ProductimagePath;
//   final List Size;
//   final List ProductReviews;
//   final String Productname;
//   final String Productdescription;
//   final String Producttype;
//   final String ProductId;
//   final int Productprice;

//   const ProductDetailScreen({
//     super.key,
//     required this.Productprice,
//     required this.Producttype,
//     required this.Productname,
//     required this.ProductimagePath,
//     required this.Size,
//     required this.Productdescription,
//     required this.ProductReviews,
//     required this.ProductId,
//   });

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProductDetailProvider>(context, listen: false);
//     final w = getScreenSize(context).width * (1 / 375);

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               _ProductImageHeader(
//                 images: widget.ProductimagePath,
//                 productId: widget.ProductId,
//               ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.05),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                 child: Column(
//                   children: [
//                     _ProductTitleSection(
//                       name: widget.Productname,
//                       type: widget.Producttype,
//                       price: widget.Productprice,
//                       w: w,
//                     ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
//                     const SizedBox(height: 15),
//                     _ProductImageThumbnails(
//                       images: widget.ProductimagePath,
//                       onSelect: provider.imageChange,
//                     ).animate().scale(duration: 400.ms, delay: 150.ms),
//                     const SizedBox(height: 15),
//                     _SizeSelectorSection(sizes: widget.Size)
//                         .animate()
//                         .fadeIn(duration: 500.ms, delay: 200.ms),
//                     const SizedBox(height: 15),
//                     _DescriptionSection(description: widget.Productdescription)
//                         .animate()
//                         .fadeIn(duration: 500.ms, delay: 250.ms),
//                     const SizedBox(height: 15),
//                     _ReviewSection(
//                       reviews: widget.ProductReviews,
//                       productId: widget.ProductId,
//                     ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
//                     const SizedBox(height: 15),
//                     _TotalPriceSection(total: widget.Productprice + 10)
//                         .animate()
//                         .fadeIn(duration: 500.ms, delay: 350.ms),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Consumer<CartAddProductProvider>(
//           builder: (context, value, child) {
//             return BottomButtons(
//               lable: 'Add to Cart',
//               ontap: () {
//                 value.addToCart(
//                   context,
//                   productId: widget.ProductId,
//                   qty: 1,
//                   price: widget.Productprice,
//                   name: widget.Productname,
//                   type: widget.Producttype,
//                   image: widget.ProductimagePath[0],
//                 );
//                 Provider.of<BottomButtomProvider>(context, listen: false)
//                     .startloading();
//               },
//             ).animate().scale(duration: 400.ms);
//           },
//         ),
//       ),
//     );
//   }
// }

// /// ------------------ Components ------------------

// class _ProductImageHeader extends StatelessWidget {
//   final List images;
//   final String productId;

//   const _ProductImageHeader({required this.images, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductDetailProvider>(
//       builder: (context, value, child) {
//         return Container(
//           height: getScreenSize(context).height / 2,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(images[(value.selectedIndex < images.length)
//                   ? value.selectedIndex
//                   : 0]),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Align(alignment: Alignment.topCenter, child: _HeaderIcons()),
//         );
//       },
//     );
//   }
// }

// class _HeaderIcons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _CircleIcon(
//           icon: Icons.arrow_back_rounded,
//           onTap: () => NavigatorPop(context),
//         ),

//         //!
//         Padding(
//           padding: const EdgeInsets.only(right: 20, top: 20),
//           child: InkWell(
//             onTap: () {
//               // navigatedFrom = '';
//               NavigatorTo(context, const CartScreen());
//             },
//             child: const Icon(
//               Icons.shopping_cart_outlined,
//               color: Colors.teal,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _CircleIcon extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _CircleIcon({required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, top: 20),
//       child: InkWell(
//         onTap: onTap,
//         splashColor: Colors.transparent,
//         child: Container(
//           height: 45,
//           width: 45,
//           decoration:
//               const BoxDecoration(shape: BoxShape.circle, color: MyColor.grey),
//           child: Icon(icon, size: 25, color: MyColor.textBlack),
//         ),
//       ),
//     );
//   }
// }

// class _ProductTitleSection extends StatelessWidget {
//   final String name;
//   final String type;
//   final int price;
//   final double w;

//   const _ProductTitleSection(
//       {required this.name,
//       required this.type,
//       required this.price,
//       required this.w});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           SizedBox(
//             width: 260 * w,
//             child: Text(
//               name,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'Inter',
//                   color: MyColor.textLight),
//             ),
//           ),
//           const Text("Price",
//               style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'Inter',
//                   color: MyColor.textLight)),
//         ]),
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Text(type,
//               style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Inter',
//                   color: MyColor.textBlack)),
//           Text("\$$price",
//               style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Inter',
//                   color: MyColor.textBlack)),
//         ]),
//       ],
//     );
//   }
// }

// class _ProductImageThumbnails extends StatelessWidget {
//   final List images;
//   final Function(int) onSelect;

//   const _ProductImageThumbnails({required this.images, required this.onSelect});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 77,
//       child: ListView.builder(
//         itemCount: images.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: InkWell(
//               onTap: () => onSelect(index),
//               child: Container(
//                 width: 77,
//                 height: 77,
//                 decoration: BoxDecoration(
//                   color: MyColor.grey,
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                       image: NetworkImage(images[index]), fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _SizeSelectorSection extends StatelessWidget {
//   final List sizes;

//   const _SizeSelectorSection({required this.sizes});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text("Variants",
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Inter',
//                     color: MyColor.textBlack)),
//           ],
//         ),
//         const SizedBox(height: 15),
//         SizedBox(
//           height: 60,
//           child: Consumer<SizeSelectorProvider>(
//             builder: (context, value, child) {
//               return ListView.builder(
//                 itemCount: sizes.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   final isSelected = value.selectedIndex == index;
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     child: InkWell(
//                       onTap: () => value.selectedSize(index),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: isSelected ? MyColor.textLight : MyColor.grey,
//                         ),
//                         child: Center(
//                           child: Text(
//                             sizes[index],
//                             style: TextStyle(
//                               color: isSelected
//                                   ? MyColor.white
//                                   : MyColor.textBlack,
//                               fontFamily: 'Inter',
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DescriptionSection extends StatelessWidget {
//   final String description;

//   const _DescriptionSection({required this.description});

//   @override
//   Widget build(BuildContext context) {
//     final w = getScreenSize(context).width * (1 / 375);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Description",
//             style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Inter',
//                 color: MyColor.textBlack)),
//         const SizedBox(height: 10),
//         SizedBox(
//           width: 335 * w,
//           child: Text(
//             description,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Inter',
//                 color: MyColor.textLight),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ReviewSection extends StatelessWidget {
//   final List reviews;
//   final String productId;

//   const _ReviewSection({required this.reviews, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           const Text("Reviews",
//               style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Inter',
//                   color: MyColor.textBlack)),
//           InkWell(
//             onTap: () =>
//                 NavigatorTo(context, ReviewsScreen(productId: productId)),
//             child: const Text("View all",
//                 style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'Inter',
//                     color: MyColor.textLight)),
//           ),
//         ]),
//         const SizedBox(height: 15),
//         (reviews.isNotEmpty)
//             ? ReviewTile(
//                 ratings: reviews[0]['rating'],
//                 date: reviews[0]['time'],
//                 review: reviews[0]['review'],
//                 userName: reviews[0]['name'],
//               )
//             : const Center(
//                 child: Text("No Review ",
//                     style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: 'Inter',
//                         color: MyColor.textLight))),
//       ],
//     );
//   }
// }

// class _TotalPriceSection extends StatelessWidget {
//   final int total;

//   const _TotalPriceSection({required this.total});

//   @override
//   Widget build(BuildContext context) {
//     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       const Column(
//         children: [
//           Text("Total Price",
//               style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Inter',
//                   color: MyColor.textBlack)),
//           Text("with VAT,SD",
//               style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'Inter',
//                   color: MyColor.textLight)),
//         ],
//       ),
//       Text("\$$total",
//           style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Inter',
//               color: MyColor.textBlack)),
//     ]);
//   }
// }

// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:laza/Providers/bottom_buttom_provider.dart';
// import 'package:laza/Providers/cart_add_product.dart';
// import 'package:laza/Providers/product_detail_provider.dart';
// import 'package:laza/Providers/size_selector_provider.dart';
// import 'package:laza/Resources/MediaQuery/media_query.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Resources/Widgets/review_tile.dart';
// import 'package:laza/Cart/Screens/cart_screen.dart';
// import 'package:laza/Reviews/Screens/reviews_screen.dart';
// import 'package:provider/provider.dart';
// import '../Resources/Paths/imports.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final List ProductimagePath;
//   final List Size;
//   final List ProductReviews;
//   final String Productname;
//   final String Productdescription;
//   final String Producttype;
//   final String ProductId;
//   final int Productprice;

//   const ProductDetailScreen({
//     super.key,
//     required this.Productprice,
//     required this.Producttype,
//     required this.Productname,
//     required this.ProductimagePath,
//     required this.Size,
//     required this.Productdescription,
//     required this.ProductReviews,
//     required this.ProductId,
//   });

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // final provider = Provider.of<ProductDetailProvider>(context, listen: false);
//     final w = getScreenSize(context).width * (1 / 375);

//     showPrice() {
//       if (widget.Producttype == 'tablet') {
//         return Text(
//           'per tablet',
//           style: GoogleFonts.poppins(
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             // fontFamily: 'Inter',
//             color: Colors.teal.shade600,
//             letterSpacing: 0.5,
//           ),
//         );
//       } else {
//         return Text(
//           'Price',
//           style: GoogleFonts.poppins(
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             // fontFamily: 'Inter',
//             color: Colors.teal.shade600,
//             letterSpacing: 0.5,
//           ),
//         );
//       }
//     }

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade50,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               _ProductImageHeader(
//                 images: widget.ProductimagePath,
//                 productId: widget.ProductId,
//               ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.05),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, -5),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
//                   child: Column(
//                     children: [
//                       _ProductTitleSection(
//                         name: widget.Productname,
//                         type: widget.Producttype,
//                         price: widget.Productprice,
//                         showPrice: showPrice(),
//                         w: w,
//                       ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
//                       const SizedBox(height: 20),
//                       // _ProductImageThumbnails(
//                       //   images: widget.ProductimagePath,
//                       //   onSelect: provider.imageChange,
//                       // ).animate().scale(duration: 400.ms, delay: 150.ms),
//                       const SizedBox(height: 25),
//                       _SizeSelectorSection(sizes: widget.Size)
//                           .animate()
//                           .fadeIn(duration: 500.ms, delay: 200.ms),
//                       const SizedBox(height: 25),
//                       _DescriptionSection(
//                               description: widget.Productdescription)
//                           .animate()
//                           .fadeIn(duration: 500.ms, delay: 250.ms),
//                       const SizedBox(height: 25),
//                       _ReviewSection(
//                         reviews: widget.ProductReviews,
//                         productId: widget.ProductId,
//                       ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
//                       const SizedBox(height: 25),
//                       _TotalPriceSection(total: widget.Productprice + 10)
//                           .animate()
//                           .fadeIn(duration: 500.ms, delay: 350.ms),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 20,
//                 offset: const Offset(0, -10),
//               ),
//             ],
//           ),
//           child: Consumer<CartAddProductProvider>(
//             builder: (context, value, child) {
//               return Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     value.addToCart(
//                       context,
//                       productId: widget.ProductId,
//                       qty: 1,
//                       price: widget.Productprice,
//                       name: widget.Productname,
//                       type: widget.Producttype,
//                       image: widget.ProductimagePath[0],
//                     );
//                     Provider.of<BottomButtomProvider>(context, listen: false)
//                         .startloading();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     foregroundColor: Colors.white,
//                     elevation: 8,
//                     shadowColor: Colors.teal.withOpacity(0.4),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 18),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                     const   Icon(Icons.shopping_cart_outlined, size: 22),
//                    const    SizedBox(width: 10),
//                       Text(
//                         'Add to Cart',
//                         style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ).animate().scale(duration: 400.ms),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ------------------ Components ------------------

// class _ProductImageHeader extends StatelessWidget {
//   final List images;
//   final String productId;

//   const _ProductImageHeader({required this.images, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductDetailProvider>(
//       builder: (context, value, child) {
//         return Container(
//           height: getScreenSize(context).height / 2,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 15,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//             // gradient: LinearGradient(colors: [
//             //   Colors.teal[600]!,
//             //   Colors.teal[500]!,
//             //   Colors.teal[300]!
//             // ])
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30),
//             ),
//             child: Stack(
//               children: [
//                 // Product Image with gradient overlay
//                 Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   decoration: BoxDecoration(
//                     // borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       filterQuality: FilterQuality.high,
//                       image: NetworkImage(images[
//                           (value.selectedIndex < images.length)
//                               ? value.selectedIndex
//                               : 0]),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 // Gradient overlay for better text visibility
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.center,
//                       colors: [
//                         Colors.black.withOpacity(0.3),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Header icons
//                 SafeArea(
//                   child: _HeaderIcons(),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _HeaderIcons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _CircleIcon(
//             icon: Icons.arrow_back_rounded,
//             onTap: () => NavigatorPop(context),
//           ),
//           _CircleIcon(
//             icon: Icons.shopping_cart_outlined,
//             onTap: () => NavigatorTo(context, const CartScreen()),
//             color: Colors.teal,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _CircleIcon extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;
//   final Color? color;

//   const _CircleIcon({required this.icon, required this.onTap, this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(25),
//         child: Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white.withOpacity(0.9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.15),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Icon(
//             icon,
//             size: 24,
//             color: color ?? MyColor.textBlack,
//           ),
//         ),
//       ),
//     );
//   }
// }
// //! first container :::

// class _ProductTitleSection extends StatelessWidget {
//   final String name;
//   final String type;
//   final int price;
//   final double w;
//   final showPrice;

//   const _ProductTitleSection(
//       {required this.name,
//       required this.type,
//       required this.price,
//       required this.showPrice,
//       required this.w});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Product Name",
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       // fontFamily: 'Inter',
//                       color: Colors.teal.shade600,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     name,
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Inter',
//                       color: MyColor.textBlack,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 showPrice,
//                 const SizedBox(height: 4),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.teal.shade600, Colors.teal.shade500],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.teal.withOpacity(0.3),
//                         blurRadius: 8,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(Icons.attach_money_rounded,
//                           color: Colors.white, size: 18),
//                       Text(
//                         price.toString(),
//                         style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           // fontFamily: 'Inter',
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ]),
//           const SizedBox(height: 15),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.red.shade50,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.red),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.category_outlined,
//                     color: Colors.red, size: 19),
//                 const SizedBox(width: 8),
//                 Text(
//                   "Category: ",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     // fontWeight: FontWeight.w500,
//                     color: Colors.red,
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     type,
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       // fontFamily: 'Inter',
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class _ProductImageThumbnails extends StatelessWidget {
// //   final List images;
// //   final Function(int) onSelect;

// //   const _ProductImageThumbnails({required this.images, required this.onSelect});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           "Product Gallery",
// //           style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.w600,
// //             fontFamily: 'Inter',
// //             color: MyColor.textBlack,
// //           ),
// //         ),
// //         const SizedBox(height: 15),
// //         Container(
// //           height: 85,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(15),
// //             color: Colors.grey.shade50,
// //           ),
// //           child: ListView.builder(
// //             itemCount: images.length,
// //             scrollDirection: Axis.horizontal,
// //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //             itemBuilder: (context, index) {
// //               return Consumer<ProductDetailProvider>(
// //                 builder: (context, provider, child) {
// //                   final isSelected = provider.selectedIndex == index;
// //                   return Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 6),
// //                     child: Material(
// //                       color: Colors.transparent,
// //                       child: InkWell(
// //                         onTap: () => onSelect(index),
// //                         borderRadius: BorderRadius.circular(18),
// //                         child: Container(
// //                           width: 77,
// //                           height: 77,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(18),
// //                             border: Border.all(
// //                               color: isSelected
// //                                   ? Colors.teal
// //                                   : Colors.grey.shade300,
// //                               width: isSelected ? 2.5 : 1,
// //                             ),
// //                             boxShadow: isSelected
// //                                 ? [
// //                                     BoxShadow(
// //                                       color: Colors.teal.withOpacity(0.3),
// //                                       blurRadius: 8,
// //                                       offset: const Offset(0, 4),
// //                                     ),
// //                                   ]
// //                                 : null,
// //                           ),
// //                           child: ClipRRect(
// //                             borderRadius: BorderRadius.circular(16),
// //                             child: Image.network(
// //                               images[index],
// //                               fit: BoxFit.cover,
// //                               errorBuilder: (context, error, stackTrace) {
// //                                 return Container(
// //                                   color: Colors.grey.shade200,
// //                                   child: const Icon(Icons.image_outlined,
// //                                       color: Colors.grey),
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// class _SizeSelectorSection extends StatelessWidget {
//   final List sizes;

//   const _SizeSelectorSection({required this.sizes});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Icon(Icons.straighten, color: Colors.teal, size: 20),
//             const SizedBox(width: 8),
//             Text(
//               "Available Variants",
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 // fontFamily: 'Inter',
//                 color: MyColor.textBlack,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 15),
//         Container(
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Consumer<SizeSelectorProvider>(
//             builder: (context, value, child) {
//               return Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: List.generate(sizes.length, (index) {
//                   final isSelected = value.selectedIndex == index;
//                   return Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () => value.selectedSize(index),
//                       borderRadius: BorderRadius.circular(12),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 12),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: isSelected
//                               ? LinearGradient(
//                                   colors: [
//                                     Colors.teal.shade600,
//                                     Colors.teal.shade500
//                                   ],
//                                 )
//                               : null,
//                           color: isSelected ? null : Colors.white,
//                           border: Border.all(
//                             color: isSelected
//                                 ? Colors.transparent
//                                 : Colors.grey.shade300,
//                           ),
//                           boxShadow: isSelected
//                               ? [
//                                   BoxShadow(
//                                     color: Colors.teal.withOpacity(0.3),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ]
//                               : [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.05),
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                         ),
//                         child: Text(
//                           sizes[index],
//                           style: TextStyle(
//                             color:
//                                 isSelected ? Colors.white : MyColor.textBlack,
//                             fontFamily: 'Inter',
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DescriptionSection extends StatelessWidget {
//   final String description;

//   const _DescriptionSection({required this.description});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.description_outlined,
//                   color: Colors.teal, size: 20),
//               const SizedBox(width: 8),
//               Text(
//                 "Description",
//                 style: GoogleFonts.poppins(
//                   fontSize: 18.5,
//                   fontWeight: FontWeight.w500,
//                   // fontFamily: 'Inter',
//                   color: MyColor.purple,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             description,
//             style: GoogleFonts.poppins(
//               fontSize: 15,
//               fontWeight: FontWeight.w400,
//               // fontFamily: 'Inter',
//               color: MyColor.textBlack,
//               height: 1.5,
//               letterSpacing: 0.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ReviewSection extends StatelessWidget {
//   final List reviews;
//   final String productId;

//   const _ReviewSection({required this.reviews, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.star_rounded,
//                       color: Colors.amber.shade500, size: 22),
//                   const SizedBox(width: 8),
//                   Text(
//                     "Reviews",
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Inter',
//                       color: MyColor.textBlack,
//                     ),
//                   ),
//                 ],
//               ),
//               Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () =>
//                       NavigatorTo(context, ReviewsScreen(productId: productId)),
//                   borderRadius: BorderRadius.circular(8),
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.teal.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.teal.shade200),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "View all",
//                           style: GoogleFonts.poppins(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             // fontFamily: 'Inter',
//                             color: Colors.teal.shade700,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         Icon(Icons.arrow_forward_ios,
//                             size: 12, color: Colors.teal.shade700),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           (reviews.isNotEmpty)
//               ? Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: ReviewTile(
//                     //!Resources/Widgets/review_tile.dart
//                     imageUrl: reviews[0]['image'] ,
//                     ratings: reviews[0]['rating'],
//                     date: reviews[0]['time'],
//                     review: reviews[0]['review'],
//                     userName: reviews[0]['name'],
//                   ),
//                 )
//               : Container(
//                   padding: const EdgeInsets.symmetric(vertical: 30),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     border: Border.all(
//                         color: Colors.grey.shade200, style: BorderStyle.solid),
//                   ),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         Icon(Icons.rate_review_outlined,
//                             color: Colors.grey.shade400, size: 40),
//                         const SizedBox(height: 10),
//                         Text(
//                           "No Reviews Yet",
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             // fontFamily: 'Inter',
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                         Text(
//                           "Be the first to review this product",
//                           style: GoogleFonts.poppins(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             // fontFamily: 'Inter',
//                             color: Colors.grey.shade500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }

// class _TotalPriceSection extends StatelessWidget {
//   final int total;

//   const _TotalPriceSection({required this.total});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.teal.shade50, Colors.teal.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.teal.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Total Price",
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   // fontFamily: 'Inter',
//                   color: Colors.teal.shade800,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "Including VAT & Service Delivery",
//                 style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   // fontFamily: 'Inter',
//                   color: Colors.teal.shade600,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.teal.shade600, Colors.teal.shade500],
//               ),
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.teal.withOpacity(0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.attach_money_rounded,
//                     color: Colors.white, size: 20),
//                 Text(
//                   total.toString(),
//                   style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     // fontFamily: 'Inter',
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:laza/Features/Cart/providers/cart_add_product.dart';
import 'package:laza/Features/Product_DetailScreen/provider/product_detail_provider.dart';
import 'package:laza/Features/Reviews/providers/size_selector_provider.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/review_tile.dart';
import 'package:laza/Features/Cart/Screens/cart_screen.dart';
import 'package:laza/Features/Reviews/Screens/reviews_screen.dart';
import 'package:provider/provider.dart';
import '../../../Resources/Paths/imports.dart';

class ProductDetailScreen extends StatefulWidget {
  final List ProductimagePath;
  final List Size;
  final List ProductReviews;
  final String Productname;
  final String Productdescription;
  final String Producttype;
  final String ProductId;
  final int Productprice;

  const ProductDetailScreen({
    super.key,
    required this.Productprice,
    required this.Producttype,
    required this.Productname,
    required this.ProductimagePath,
    required this.Size,
    required this.Productdescription,
    required this.ProductReviews,
    required this.ProductId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductDetailProvider>(context, listen: false);
    final w = getScreenSize(context).width * (1 / 375);

    showPrice() {
      if (widget.Producttype == 'tablet') {
        return Text(
          'per tablet',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            // fontFamily: 'Inter',
            color: Colors.teal.shade600,
            letterSpacing: 0.5,
          ),
        );
      } else {
        return Text(
          'Price',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            // fontFamily: 'Inter',
            color: Colors.teal.shade600,
            letterSpacing: 0.5,
          ),
        );
      }
    }

    Future<void> refreshData() async {
      setState(() {}); // Trigger a rebuild to refresh the UI with existing data
      await Future.delayed(const Duration(milliseconds: 500)); // Brief delay for feedback
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: RefreshIndicator(
          onRefresh: refreshData,
          color: Colors.teal,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _ProductImageHeader(
                  images: widget.ProductimagePath,
                  productId: widget.ProductId,
                ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.05),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Column(
                      children: [
                        _ProductTitleSection(
                          name: widget.Productname,
                          type: widget.Producttype,
                          price: widget.Productprice,
                          showPrice: showPrice(),
                          w: w,
                        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
                        const SizedBox(height: 20),
                        // _ProductImageThumbnails(
                        //   images: widget.ProductimagePath,
                        //   onSelect: provider.imageChange,
                        // ).animate().scale(duration: 400.ms, delay: 150.ms),
                        const SizedBox(height: 25),
                        _SizeSelectorSection(sizes: widget.Size)
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 200.ms),
                        const SizedBox(height: 25),
                        _DescriptionSection(
                                description: widget.Productdescription)
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 250.ms),
                        const SizedBox(height: 25),
                        _ReviewSection(
                          reviews: widget.ProductReviews,
                          productId: widget.ProductId,
                        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
                        const SizedBox(height: 25),
                        _TotalPriceSection(total: widget.Productprice + 10)
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 350.ms),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Consumer<CartAddProductProvider>(
            builder: (context, value, child) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    value.addToCart(
                      context,
                      productId: widget.ProductId,
                      qty: 1,
                      price: widget.Productprice,
                      name: widget.Productname,
                      type: widget.Producttype,
                      image: widget.ProductimagePath[0],
                    );
                    Provider.of<BottomButtomProvider>(context, listen: false)
                        .startloading();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.teal.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_cart_outlined, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Add to Cart',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(duration: 400.ms),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// ------------------ Components ------------------

class _ProductImageHeader extends StatelessWidget {
  final List images;
  final String productId;

  const _ProductImageHeader({required this.images, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(
      builder: (context, value, child) {
        return Container(
          height: getScreenSize(context).height / 2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
            // gradient: LinearGradient(colors: [
            //   Colors.teal[600]!,
            //   Colors.teal[500]!,
            //   Colors.teal[300]!
            // ])
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Stack(
              children: [
                // Product Image with gradient overlay
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      filterQuality: FilterQuality.high,
                      image: NetworkImage(images[
                          (value.selectedIndex < images.length)
                              ? value.selectedIndex
                              : 0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient overlay for better text visibility
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Header icons
                SafeArea(
                  child: _HeaderIcons(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleIcon(
            icon: Icons.arrow_back_rounded,
            onTap: () => NavigatorPop(context),
          ),
          _CircleIcon(
            icon: Icons.shopping_cart_outlined,
            onTap: () => NavigatorTo(context, const CartScreen()),
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _CircleIcon({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 24,
            color: color ?? MyColor.textBlack,
          ),
        ),
      ),
    );
  }
}

//! first container :::

class _ProductTitleSection extends StatelessWidget {
  final String name;
  final String type;
  final int price;
  final double w;
  final showPrice;

  const _ProductTitleSection(
      {required this.name,
      required this.type,
      required this.price,
      required this.showPrice,
      required this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Name",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      // fontFamily: 'Inter',
                      color: Colors.teal.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      // fontFamily: 'Inter',
                      color: MyColor.textBlack,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                showPrice,
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade600, Colors.teal.shade500],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.attach_money_rounded,
                          color: Colors.white, size: 18),
                      Text(
                        price.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          // fontFamily: 'Inter',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red),
            ),
            child: Row(
              children: [
                const Icon(Icons.category_outlined,
                    color: Colors.red, size: 19),
                const SizedBox(width: 8),
                Text(
                  "Category: ",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    // fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: Text(
                    type,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      // fontFamily: 'Inter',
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _ProductImageThumbnails extends StatelessWidget {
//   final List images;
//   final Function(int) onSelect;

//   const _ProductImageThumbnails({required this.images, required this.onSelect});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Product Gallery",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             fontFamily: 'Inter',
//             color: MyColor.textBlack,
//           ),
//         ),
//         const SizedBox(height: 15),
//         Container(
//           height: 85,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.grey.shade50,
//           ),
//           child: ListView.builder(
//             itemCount: images.length,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             itemBuilder: (context, index) {
//               return Consumer<ProductDetailProvider>(
//                 builder: (context, provider, child) {
//                   final isSelected = provider.selectedIndex == index;
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 6),
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () => onSelect(index),
//                         borderRadius: BorderRadius.circular(18),
//                         child: Container(
//                           width: 77,
//                           height: 77,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(18),
//                             border: Border.all(
//                               color: isSelected
//                                   ? Colors.teal
//                                   : Colors.grey.shade300,
//                               width: isSelected ? 2.5 : 1,
//                             ),
//                             boxShadow: isSelected
//                                 ? [
//                                     BoxShadow(
//                                       color: Colors.teal.withOpacity(0.3),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ]
//                                 : null,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.network(
//                               images[index],
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   color: Colors.grey.shade200,
//                                   child: const Icon(Icons.image_outlined,
//                                       color: Colors.grey),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class _SizeSelectorSection extends StatelessWidget {
  final List sizes;

  const _SizeSelectorSection({required this.sizes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.straighten, color: Colors.teal, size: 20),
            const SizedBox(width: 8),
            Text(
              "Available Variants",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                // fontFamily: 'Inter',
                color: MyColor.textBlack,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Consumer<SizeSelectorProvider>(
            builder: (context, value, child) {
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(sizes.length, (index) {
                  final isSelected = value.selectedIndex == index;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => value.selectedSize(index),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    Colors.teal.shade600,
                                    Colors.teal.shade500
                                  ],
                                )
                              : null,
                          color: isSelected ? null : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.teal.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                        ),
                        child: Text(
                          sizes[index],
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : MyColor.textBlack,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final String description;

  const _DescriptionSection({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description_outlined,
                  color: Colors.teal, size: 20),
              const SizedBox(width: 8),
              Text(
                "Description",
                style: GoogleFonts.poppins(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w500,
                  // fontFamily: 'Inter',
                  color: MyColor.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              // fontFamily: 'Inter',
              color: MyColor.textBlack,
              height: 1.5,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewSection extends StatelessWidget {
  final List reviews;
  final String productId;

  const _ReviewSection({required this.reviews, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star_rounded,
                      color: Colors.amber.shade500, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    "Reviews",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      // fontFamily: 'Inter',
                      color: MyColor.textBlack,
                    ),
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () =>
                      NavigatorTo(context, ReviewsScreen(productId: productId)),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "View all",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            // fontFamily: 'Inter',
                            color: Colors.teal.shade700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios,
                            size: 12, color: Colors.teal.shade700),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          (reviews.isNotEmpty)
              ? Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ReviewTile(
                    //!Resources/Widgets/review_tile.dart
                    imageUrl: reviews[0]['image'],
                    ratings: reviews[0]['rating'],
                    date: reviews[0]['time'],
                    review: reviews[0]['review'],
                    userName: reviews[0]['name'],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.grey.shade200, style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.rate_review_outlined,
                            color: Colors.grey.shade400, size: 40),
                        const SizedBox(height: 10),
                        Text(
                          "No Reviews Yet",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // fontFamily: 'Inter',
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          "Be the first to review this product",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            // fontFamily: 'Inter',
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _TotalPriceSection extends StatelessWidget {
  final int total;

  const _TotalPriceSection({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.teal.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  // fontFamily: 'Inter',
                  color: Colors.teal.shade800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Including VAT & Service Delivery",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  // fontFamily: 'Inter',
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade600, Colors.teal.shade500],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.attach_money_rounded,
                    color: Colors.white, size: 20),
                Text(
                  total.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}