import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Reviews/Database_reviewAdding/review.dart';
import 'package:laza/Features/Reviews/providers/star_slider_provider.dart';
import 'package:laza/Resources/Widgets/reviewTextfield.dart';
import 'package:provider/provider.dart';
import '../../../Resources/MediaQuery/media_query.dart';
import '../../../Resources/Paths/imports.dart';
import '../../../Resources/Widgets/reuseable_appbar.dart';

class AddReviewScreen extends StatefulWidget {
  final String? projectId;
  const AddReviewScreen({super.key, this.projectId});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  // Define consistent teal color palette
  static const Color primaryTeal = Color(0xFF009688);
  static const Color lightTeal = Color(0xFF4DB6AC);
  static const Color darkTeal = Color(0xFF00695C);
  static const Color accentTeal = Color(0xFF80CBC4);
  static const Color backgroundTeal = Color(0xFFE0F2F1);
  static const Color surfaceTeal = Color(0xFFF1F8F7);

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);
    final provider = Provider.of<StarSliderProvider>(context, listen: false);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[200],
        appBar: buildAppBar(context, 'Add Review'),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Card with Teal Gradient
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primaryTeal,
                              lightTeal,
                              // accentTeal.withOpacity(0.8),
                              Colors.teal,
                              Colors.teal,
                              Colors.teal.withOpacity(0.6),
                              Colors.teal.withOpacity(0.05),
                              // const Color(0xFF4DD0E1),
                              // const Color(0xFF00BCD4),
                              accentTeal.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: primaryTeal.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.rate_review_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Share Your Experience',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Your feedback helps us improve',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Name Input Section
                      _buildSectionCard(
                        title: 'Your Name',
                        icon: Icons.person_rounded,
                        child: ReuseableTextfield(
                          title: '',
                          controller: nameController,
                          hint: 'Enter your full name',
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Experience Section
                      _buildSectionCard(
                        title: 'Your Experience',
                        icon: Icons.comment_rounded,
                        child: _buildReviewTextField(),
                      ),

                      const SizedBox(height: 24),

                      // Rating Section
                      _buildSectionCard(
                        title: 'Rate Your Experience',
                        icon: Icons.star_rounded,
                        child: Column(
                          children: [
                            _buildStarDisplay(),
                            const SizedBox(height: 16),
                            _buildStarSlider(context),
                          ],
                        ),
                      ),

                      if (!isKeyboardOpen) SizedBox(height: 180 * h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: primaryTeal.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: _buildSubmitButton(),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentTeal.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryTeal.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      accentTeal.withOpacity(0.2),
                      lightTeal.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: primaryTeal,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildReviewTextField() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accentTeal.withOpacity(0.4),
          width: 1.5,
        ),
        gradient: LinearGradient(
          colors: [
            surfaceTeal,
            accentTeal.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: TextFormField(
          maxLines: 10,
          controller: reviewController,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
          decoration: InputDecoration(
            hintText: 'Tell us about your experience in detail...',
            hintStyle: GoogleFonts.poppins(
              // color: primaryTeal.withOpacity(0.6),
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }

  Widget _buildStarDisplay() {
    return Consumer<StarSliderProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  index < value.value.round()
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: index < value.value.round()
                      ? const Color(0xFFFFA726) // Amber color for stars
                      : accentTeal.withOpacity(0.4),
                  size: 32,
                ),
              );
            }),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightTeal.withOpacity(0.2),
                    accentTeal.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: primaryTeal.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                value.value.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  color: darkTeal,
                  // color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStarSlider(BuildContext context) {
    return Column(
      children: [
        Consumer<StarSliderProvider>(
          builder: (context, value, child) {
            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: primaryTeal,
                inactiveTrackColor: accentTeal.withOpacity(0.3),
                thumbColor: lightTeal,
                overlayColor: primaryTeal.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                trackHeight: 6,
              ),
              child: Slider(
                value: value.value,
                max: 5,
                min: 0,
                divisions: 10,
                onChanged: value.changeValue,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSliderLabel('0.0', 'Poor'),
              _buildSliderLabel('2.5', 'Average'),
              _buildSliderLabel('5.0', 'Excellent'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliderLabel(String rating, String label) {
    return Column(
      children: [
        Text(
          rating,
          style: GoogleFonts.poppins(
            color: primaryTeal,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            // color: darkTeal.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Consumer<StarSliderProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                primaryTeal,
                lightTeal,
                accentTeal,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: primaryTeal.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                addReview(
                  
                  widget.projectId,
                  nameController.text.trim(),
                  
                  reviewController.text.trim(),
                  provider.value,
                  
                  context,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Submit Review',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
