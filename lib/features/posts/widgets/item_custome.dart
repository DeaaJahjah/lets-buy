import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class ItemCustom extends StatelessWidget {
  final String? urlImage;
  final String address;
  final String type;
  final String category;
  final String price;
  final Function()? onDelete;
  final Function()? onEdit;
  const ItemCustom(
      {Key? key,
      required this.urlImage,
      required this.address,
      required this.type,
      required this.category,
      required this.price,
      this.onDelete,
      this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: purple,
                border: Border.all(color: white.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(10)),
            height: 130,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                      height: 130,
                      width: 130,
                      margin: const EdgeInsets.only(left: 5, right: 20),
                      child: (urlImage != null)
                          ? Image.network(urlImage!, fit: BoxFit.cover)
                          : const Center(child: Text('لا يوجد صور', style: style2))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text('العنوان ', style: style2),
                          Text(type, style: textStyle),
                        ],
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Text('السعر ', style: style2),
                          Text(price + 'ل.س', style: textStyle),
                        ],
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Text('النوع ', style: style2),
                          Text(category, style: textStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(icon: const Icon(Icons.delete, color: white, size: 25), onPressed: onDelete),
                  (onEdit != null)
                      ? IconButton(icon: const Icon(Icons.edit, color: white, size: 25), onPressed: onEdit)
                      : const SizedBox.shrink()
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
