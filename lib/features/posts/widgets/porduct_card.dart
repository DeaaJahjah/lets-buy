import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/features/posts/screens/details_screen.dart';

class ProductCard extends StatefulWidget {
  bool isFavorite;
  final String? imageProduct;
  final String type;
  final String price;
  final String address;
  final String postId;
  final String productStatus;

  ProductCard({
    Key? key,
    required this.imageProduct,
    required this.isFavorite,
    required this.type,
    required this.productStatus,
    required this.address,
    required this.price,
    required this.postId,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                        postId: widget.postId,
                      )))
              .then((value) {
            setState(() {
              widget.isFavorite = value;
            });
          });
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: dark,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: purple,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: (widget.imageProduct != null)
                                ? Image.network(
                                    widget.imageProduct!,
                                    fit: BoxFit.cover,

                                    //width: double.infinity,
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'لا يوجد صور',
                                      style: style2,
                                    ),
                                  )),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(widget.),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleWithIcon(title: widget.type, icon: Icons.location_on),
                                IconButton(
                                  icon: (widget.isFavorite)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(Icons.favorite_outline),
                                  onPressed: () async {
                                    if (widget.isFavorite) {
                                      await UserDbServices().removeFromFavourites(widget.postId);
                                    } else {
                                      await UserDbServices().addToFivourites(widget.postId);
                                    }
                                    setState(() {
                                      widget.isFavorite = !widget.isFavorite;
                                    });
                                  },
                                  color: white,
                                )
                              ],
                            ),
                            titleWithIcon(title: widget.productStatus, icon: Icons.category_rounded),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget.price} ل.س',
                                  style: const TextStyle(
                                      color: white, fontSize: 12, fontFamily: font, fontWeight: FontWeight.bold),
                                ),
                                // titleWithIcon(title: widget.price, icon: Icons.attach_money),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 42,
                //   left: 0,
                //   right: 0,
                //   child:
                // ),
              ],
            )));
  }
}

Widget titleWithIcon({required String title, required IconData icon}) {
  return Row(
    children: [
      Icon(icon, color: white, size: 18),
      const SizedBox(
        width: 5,
      ),
      Text(
        title.split(' ').first,
        style: const TextStyle(color: white, fontSize: 12, fontFamily: font, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
