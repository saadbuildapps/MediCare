// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:laza/Resources/MediaQuery/media_query.dart';
// import 'package:laza/Resources/Paths/AssetsPath.dart';
// import 'package:laza/Resources/Widgets/review_tile.dart';
// import 'package:laza/Veiw/shoping_screen/add_review_screen.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// import '../Resources/Navigators/navigators.dart';
// import '../Resources/Paths/imports.dart';

// class ReviewsScreen extends StatefulWidget {
//   final String? productId;
//   const ReviewsScreen({super.key, this.productId});

//   @override
//   State<ReviewsScreen> createState() => _ReviewsScreenState();
// }

// class _ReviewsScreenState extends State<ReviewsScreen> {
//   Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
//     return FirebaseFirestore.instance
//         .collection('MedCareProducts')
//         .doc(widget.productId)
//         .get();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: Consumer(
//         builder: (context, value, child) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: RefreshIndicator(
//                 onRefresh: () async {
//                   await getUserData();
//                   setState(() {});
//                   await Future.delayed(const Duration(seconds: 1));
//                 },
//                 child: Column(
//                   children: [
//                     _buildHeader(context)
//                         .animate()
//                         .fade(duration: 500.ms)
//                         .slide(begin: const Offset(0, -0.1)),
//                     const SizedBox(height: 30),
//                     _buildReviewList(context)
//                         .animate()
//                         .fade(duration: 500.ms)
//                         .scale(begin: const Offset(0.95, 0.95)),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       title: const Text(
//         'Reviews',
//         style: TextStyle(
//           fontFamily: "Inter",
//           fontSize: 17,
//           fontWeight: FontWeight.w600,
//           color: MyColor.textBlack,
//         ),
//       ),
//       centerTitle: true,
//       backgroundColor: MyColor.white,
//       toolbarHeight: 90,
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 20),
//         child: InkWell(
//           splashColor: Colors.transparent,
//           onTap: () => NavigatorPop(context),
//           child: Container(
//             height: 45,
//             width: 45,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: MyColor.grey,
//             ),
//             child: const Icon(
//               Icons.arrow_back_rounded,
//               size: 25,
//               color: MyColor.textBlack,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Reviews',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Inter',
//                 color: MyColor.textBlack,
//               ),
//             ),

//           ],
//         ),
//         InkWell(
//           onTap: () => NavigatorTo(
//             context,
//             AddReviewScreen(projectId: widget.productId),
//           ),
//           child: Container(
//             height: 35,
//             width: 114,
//             decoration: BoxDecoration(
//               color: const Color(0xffFF7043),
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(Images.addReview),
//                 const SizedBox(width: 5),
//                 const Text(
//                   'Add Review',
//                   style: TextStyle(
//                     color: MyColor.white,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Inter',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildReviewList(BuildContext context) {
//     return SizedBox(
//       height: getScreenSize(context).height - 162,
//       child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         future: getUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text(
//                 'No Data found',
//                 style: TextStyle(
//                   color: MyColor.textBlack,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 17,
//                 ),
//               ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: LoadingAnimationWidget.stretchedDots(
//                 color: MyColor.purple,
//                 size: 50,
//               ),
//             );
//           } else {
//             final reviews = snapshot.data?.data()?['reviews'] ?? [];
//             return ListView.builder(
//               itemCount: reviews.length,
//               itemBuilder: (context, index) {
//                 final review = reviews[index];
//                 return ReviewTile(
//                   ratings: review['rating'],
//                   date: review['time'],
//                   review: review['review'],
//                   userName: review['name'],
//                 )
//                     .animate()
//                     .fade(duration: 400.ms, delay: (index * 100).ms) // staggered animation
//                     .slideX(begin: -0.1);
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Resources/Widgets/review_tile.dart';
import 'package:laza/Features/Reviews/Screens/add_review_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../Resources/Navigators/navigators.dart';
import '../../../Resources/Paths/imports.dart';

class ReviewsScreen extends StatefulWidget {
  final String? productId;
  const ReviewsScreen({super.key, this.productId});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return FirebaseFirestore.instance
        .collection('MedCareProducts')
        .doc(widget.productId)
        .get();
  }

  double _calculateAverageRating(List reviews) {
    if (reviews.isEmpty) return 0.0;
    double total = 0.0;
    for (var review in reviews) {
      total += (review['rating'] ?? 0.0);
    }
    return total / reviews.length;
  }

  Map<int, int> _getRatingDistribution(List reviews) {
    Map<int, int> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in reviews) {
      int rating = (review['rating'] ?? 0).round();
      if (rating >= 1 && rating <= 5) {
        distribution[rating] = distribution[rating]! + 1;
      }
    }
    return distribution;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: buildAppBar(context,
          'Reviews & Ratings'), //! Resources/Widgets/reuseable_appbar.dart
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAFAFA),
              Color(0xFFF0F0F0),
            ],
          ),
        ),
        child: Consumer(
          builder: (context, value, child) {
            return RefreshIndicator(
              color: MyColor.purple,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await getUserData();
                setState(() {});
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildHeader(context)
                          .animate()
                          .fade(duration: 500.ms)
                          .slide(begin: const Offset(0, -0.1)),
                      const SizedBox(height: 20),
                      _buildReviewStats(context)
                          .animate()
                          .fade(duration: 600.ms)
                          .scale(begin: const Offset(0.95, 0.95)),
                      const SizedBox(height: 20),
                      _buildReviewList(context)
                          .animate()
                          .fade(duration: 500.ms)
                          .scale(begin: const Offset(0.95, 0.95)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.star_rounded,
                  color: Colors.teal,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Reviews',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        // fontFamily: 'Inter',
                        color: const Color(0xFF1A1A1A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'See what others say',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => NavigatorTo(
                context,
                AddReviewScreen(projectId: widget.productId),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.teal, Color(0xFF4DB6AC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    SvgPicture.asset(
                      Images.addReview,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Add Review',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          // fontFamily: 'Inter',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStats(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final reviews = snapshot.data?.data()?['reviews'] ?? [];
        if (reviews.isEmpty) return const SizedBox.shrink();

        final averageRating = _calculateAverageRating(reviews);

        final distribution = _getRatingDistribution(reviews);

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.teal.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isSmallScreen = constraints.maxWidth < 350;
              return isSmallScreen
                  ? Column(
                      children: [
                        _ratingBox(averageRating, reviews.length),
                        const SizedBox(height: 16),
                        _breakdownBox(reviews, distribution),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: _ratingBox(averageRating, reviews.length),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          flex: 2,
                          child: _breakdownBox(reviews, distribution),
                        ),
                      ],
                    );
            },
          ),
        );
      },
    );
  }

  Widget _ratingBox(double averageRating, int reviewCount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.withOpacity(0.1),
            Colors.teal.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.teal.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_rounded,
              color: Colors.teal,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            averageRating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A1A1A),
              fontFamily: 'Inter',
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Icon(
                  index < averageRating.floor()
                      ? Icons.star_rounded
                      : index < averageRating
                          ? Icons.star_half_rounded
                          : Icons.star_outline_rounded,
                  color: Colors.amber,
                  size: 24,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              reviewCount == 1 ? '1 review' : '$reviewCount reviews',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00695C),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakdownBox(List reviews, Map<int, int> distribution) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rating Breakdown',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(5, (index) {
            int starCount = 5 - index;
            int count = distribution[starCount] ?? 0;
            double percentage = reviews.isEmpty ? 0 : count / reviews.length;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(
                    '$starCount',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.amber,
                                Colors.amber.shade600,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$count',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF666666),
                        // fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildReviewList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red.shade400,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No reviews found',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1A1A1A),
                        // fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Be the first to leave a review!',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF666666),
                        // fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                padding: const EdgeInsets.all(60),
                child: Column(
                  children: [
                    LoadingAnimationWidget.stretchedDots(
                      color: MyColor.purple,
                      size: 50,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading reviews...',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF666666),
                        fontSize: 16,
                        // fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final reviews = snapshot.data?.data()?['reviews'] ?? [];

              if (reviews.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal.withOpacity(0.1),
                              Colors.teal.withOpacity(0.05),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.rate_review_outlined,
                          size: 48,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '✨ No reviews yet',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF1A1A1A),
                          // fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Be the first to share your experience!\nYour review will help others make better decisions.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF666666),
                          // fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal.withOpacity(0.1),
                              Colors.teal.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.teal.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '🌟 Share Your Thoughts',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF00695C),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            // fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                constraints: BoxConstraints(
                  maxHeight: getScreenSize(context).height - 400,
                  minHeight: 200,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: index == reviews.length - 1 ? 0 : 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ReviewTile(
                          //! Resource/Widgets/review_tile.dart
                          imageUrl: review['image'],
                          ratings: review['rating'],
                          date: review['time'],
                          // date: '0',

                          review: review['review'],
                          userName: review['name'],
                        ),
                      ),
                    )
                        .animate()
                        .fade(duration: 400.ms, delay: (index * 100).ms)
                        .slideX(begin: -0.1);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
