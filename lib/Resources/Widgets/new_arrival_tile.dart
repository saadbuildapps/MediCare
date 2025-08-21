import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/WishList/providers/wishList_provider.dart';
import 'package:provider/provider.dart';

import '../Paths/imports.dart';

//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::
//!              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        |
//!              --------------------------------------        |
//!              **************************************        |
//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::

//! New Arrival Tile Resource/Widget
//! This widget is used to display a product in HomeScreen +  ChooseBrandScreen + AllArrivalScreen + FavouriteListScreen
class NewArrivalTile extends StatefulWidget {
  final List image;
  final String description;
  final String name;
  final List size;
  final List reviews;
  final String type;
  final int price;
  final String productId;
  final String? favProductId;
  final String brand;
  int? position;
  NewArrivalTile(
      {super.key,
      required this.image,
      required this.description,
      required this.type,
      required this.price,
      required this.productId,
      this.position,
      required this.name,
      required this.size,
      required this.reviews,
      required this.brand,
      this.favProductId});

  @override
  State<NewArrivalTile> createState() => _NewArrivalTileState();
}

class _NewArrivalTileState extends State<NewArrivalTile> {
  bool wish = false;
  final snapshotRef = FirebaseFirestore.instance
      .collection('Wishlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('WishlistItem')
      .snapshots();

  Future<void> getWishListId() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final wishlistSnapshot = await FirebaseFirestore.instance
        .collection('Wishlist')
        .doc(userId)
        .collection('WishlistItem')
        .where('ProductId', isEqualTo: widget.productId.toLowerCase())
        .get();

    setState(() {
      wish = wishlistSnapshot.docs.isNotEmpty;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishListId();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishlistProvider>(context, listen: false);
    // final fullHeight = getScreenSize(context).height;
    // final fullWidth = getScreenSize(context).width;
    // final w = getScreenSize(context).width * (1 / 375);
    // final h = getScreenSize(context).height * (1 / 812);

    return Container(
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container with Enhanced Design
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.teal.withOpacity(0.05),
                      Colors.teal.withOpacity(0.02),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.teal.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Stack(
                  children: [
                    // Product Image
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.image[0],
                          height: 150,
                          width: 130,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.medical_services_outlined,
                                color: Colors.teal,
                                size: 40,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.teal,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Wishlist Button - Positioned in top right
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer<WishlistProvider>(
                        builder: (BuildContext context, WishlistProvider value,
                            Widget? child) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                if (wish) {
                                  await provider.removeFromWishList(
                                      widget.productId, context);
                                  setState(() {
                                    wish = false;
                                  });
                                } else {
                                  await provider.addToWishlist(
                                    productId: widget.productId,
                                    Producttype: widget.type,
                                    Productname: widget.name,
                                    Productbrand: widget.brand,
                                    ProductimagePath: widget.image,
                                    Size: widget.size,
                                    Productdescription: widget.description,
                                    ProductReviews: widget.reviews,
                                    Productprice: widget.price,
                                  );
                                  setState(() {
                                    wish = true;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  wish
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: wish
                                      ? Colors.red.shade400
                                      : Colors.grey.shade600,
                                  size: 18,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Verified Badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: 10,
                            ),
                            SizedBox(width: 2),
                            Text(
                              'Verified',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Product Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      // fontFamily: 'Inter',
                      color: Colors.teal,
                      letterSpacing: -0.3,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Product Type with Icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.medication_outlined,
                          size: 12,
                          color: Colors.teal.shade600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            // fontFamily: 'Inter',
                            color: MyColor.textBlack.withOpacity(0.7),
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 12),

                  // Price and Brand Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Price Container
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //!
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.teal.shade600,
                                    Colors.teal.shade500,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
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
                                  const Icon(
                                    Icons.attach_money_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Text(
                                    widget.price.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      // fontFamily: 'Inter',
                                      color: Colors.white,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
