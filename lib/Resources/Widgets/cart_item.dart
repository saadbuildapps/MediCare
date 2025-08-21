import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Cart/providers/cart_add_product.dart';
import 'package:laza/Features/Cart/providers/cart_item_delete_provider.dart';
import 'package:provider/provider.dart';

import '../../Features/Cart/providers/cart_product_count_provider.dart';
import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class CartItemTile extends StatefulWidget {
  final String lable;
  final int price;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final Function? onDelete;
  final String imagePath;
  final String projectId;
  final int position;
  final int quantity;

  const CartItemTile({
    super.key,
    required this.lable,
    required this.price,
    required this.imagePath,
    required this.position,
    this.onDelete,
    required this.quantity,
    required this.projectId,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CartProductcountProvider>(context, listen: false);
    final delprovider =
        Provider.of<CartItemDeleteProvider>(context, listen: false);
    final fullHeight = getScreenSize(context).height;
    final fullWidth = getScreenSize(context).width;
    final h = getScreenSize(context).height * (1 / 812);
    final w = getScreenSize(context).width * (1 / 375);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 120,
        width: 335 * w,
        decoration: BoxDecoration(
          color: MyColor.grey,
          borderRadius: BorderRadius.circular(10),
        ), 
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColor.white,
                        image: DecorationImage(
                            image: NetworkImage(widget.imagePath),
                            fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Consumer(
                    builder: (BuildContext context, value, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 36,
                            width: 136 * w,
                            child: Text(
                              widget.lable,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                color: MyColor.textBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 12,
                            width: 89 * w,
                            child: Text(
                              widget.price.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                color: MyColor.textLight,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Consumer<CartAddProductProvider>(
                            builder: (BuildContext context,
                                CartAddProductProvider val, Widget? child) {
                              return Consumer<CartProductcountProvider>(builder:
                                  (BuildContext context, value, Widget? child) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: widget.onIncrement,
                                      //     () {
                                      //   // val.getCart();
                                      //   value.increaseCount(
                                      //       productId: widget.ProjectId,
                                      //       quantity: widget.quantity);
                                      // },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xffDEDEDE),
                                            )),
                                        child: Center(
                                          child: SvgPicture.asset(Images.up),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      widget.quantity.toString(),
                                      style: GoogleFonts.poppins(
                                        color: MyColor.textBlack,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                      onTap: widget.onDecrement,
                                    
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              
                                              color: const Color(0xffDEDEDE),
                                            )),
                                        child: Center(
                                          child: SvgPicture.asset(Images.down),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                            },
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
              Consumer<CartAddProductProvider>(builder: (BuildContext context,
                  CartAddProductProvider val, Widget? child) {
                return Consumer<CartItemDeleteProvider>(
                  builder: (BuildContext context, CartItemDeleteProvider value,
                      Widget? child) {
                    return InkWell(
                      onTap: () {
                        print('tap');
                        val.getCart();
                        value.remover(widget.projectId, context);
                      },
                      child: const Center(
                          child:
                              Icon(Icons.delete, color: MyColor.red, size: 20, )

                          // child: SvgPicture.asset(Images.delete),
                          ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
