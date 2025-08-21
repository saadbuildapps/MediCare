import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MediaQuery/media_query.dart';
import '../Paths/imports.dart';

//! This widget is used to display  Review on ProductDetail screen +   Review Screen
class ReviewTile extends StatelessWidget {
  String review;
  var ratings;
  String userName;
  String date;
  String? imageUrl;

  ReviewTile({
    super.key,
    required this.ratings,
    required this.date,
    required this.review,
    required this.userName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // final fullHeight= getScreenSize(context).height;
    // final fullWidth=  getScreenSize(context).width;
    // final h= getScreenSize(context).height*(1/812);
    final w = getScreenSize(context).width * (1 / 375);
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imageUrl ?? ''),
                            // image: AssetImage(
                            //   PngImages.shirt,
                            // ),
                            fit: BoxFit.fill),
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            // fontFamily: 'Inter',
                            color: MyColor.textBlack,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: MyColor.textLight,
                              size: 11,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              date,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                // fontFamily: 'Inter',
                                color: MyColor.textLight,
                              ),
                            ),
                          ],
                        ),
                      ]),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        ratings.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          // fontFamily: 'Inter',
                          color: MyColor.textBlack,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Rating ",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          // fontFamily: 'Inter',
                          color: MyColor.textLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                    width: 57,
                    child: RatingBar.builder(
                      initialRating: ratings.toDouble(),
                      itemSize: 10,
                      minRating: 1.0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        size: 5,
                        color: MyColor.mustard,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 335 * w,
            height: 63,
            child: Text(
              review,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                // fontFamily: 'Inter',
                color: MyColor.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
