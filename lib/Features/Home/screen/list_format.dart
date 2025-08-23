import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Home/screen/all_arrival_screen.dart';
import 'package:laza/Features/Product_DetailScreen/screen/product_detail_screen.dart';
import 'package:laza/Resources/Navigators/navigators.dart';

Widget buildListView(List<QueryDocumentSnapshot> products, Size screenSize) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];
      return _buildProductListCard(product, index, screenSize);
    },
  );
}

Widget _buildProductListCard(
    QueryDocumentSnapshot product, int index, Size screenSize) {
  final isDesktop = screenSize.width >= 1024;
  final isTablet = screenSize.width >= 600 && screenSize.width < 1024;
  final List<dynamic> images = product['images'] ?? [];
  final String imageUrl = images.isNotEmpty
      ? images[0] as String
      : 'https://via.placeholder.com/150';

  return Builder(builder: (context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: isDesktop
              ? 24
              : isTablet
                  ? 20
                  : 16),
      decoration: BoxDecoration(
        color: MediCareTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: MediCareTheme.shadowLight,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isDesktop
            ? 20
            : isTablet
                ? 18
                : 16),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                NavigatorTo(
                  context,
                  ProductDetailScreen(
                    Productprice: product['price'],
                    Producttype: product['type'],
                    Productname: product['name'],
                    ProductimagePath: [imageUrl],
                    Size: product['sizes'],
                    Productdescription: product['description'],
                    ProductReviews: product['reviews'],
                    ProductId: product['ProductId'],
                  ),
                );
              },
              child: Container(
                height: isDesktop
                    ? 100
                    : isTablet
                        ? 90
                        : 80,
                width: isDesktop
                    ? 100
                    : isTablet
                        ? 90
                        : 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
                width: isDesktop
                    ? 20
                    : isTablet
                        ? 18
                        : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: isDesktop
                          ? 22
                          : isTablet
                              ? 21
                              : 20,
                      color: MediCareTheme.textPrimary,
                    ),
                  ),
                  SizedBox(
                      height: isDesktop
                          ? 8
                          : isTablet
                              ? 6
                              : 4),
                  Text(
                    product['type'],
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop
                          ? 16
                          : isTablet
                              ? 15
                              : 14,
                      color: MediCareTheme.textSecondary,
                    ),
                  ),
                  SizedBox(
                      height: isDesktop
                          ? 12
                          : isTablet
                              ? 10
                              : 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop
                              ? 10
                              : isTablet
                                  ? 9
                                  : 8,
                          vertical: isDesktop
                              ? 6
                              : isTablet
                                  ? 5
                                  : 4,
                        ),
                        decoration: BoxDecoration(
                          color: MediCareTheme.primaryTeal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '\$${product['price']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: MediCareTheme.primaryTeal,
                            fontSize: isDesktop
                                ? 16
                                : isTablet
                                    ? 15
                                    : 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fade(duration: 600.ms, delay: (80 * index).ms)
        .slideX(begin: 0.2, end: 0, duration: 500.ms);
  });
}
