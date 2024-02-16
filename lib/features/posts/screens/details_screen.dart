import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/widgets/text_row.dart';
import 'package:lets_buy/core/services/report_db_service.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
// import 'package:lets_buy/features/chat/services/stream_chat_service.dart';
import 'package:lets_buy/features/posts/models/post.dart';
import 'package:lets_buy/features/posts/providers/posts_provider.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/posts/widgets/similer_stuff.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = 'details_screen';
  final String? postId;
  final bool isFavorite;
  const DetailsScreen({Key? key, this.postId, required this.isFavorite}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> imgList = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  UserModel? userModel;
  bool loading = true;
  bool state = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        UserDbServices().getUser(uid).then((value) {
          setState(() {
            userModel = value;
            loading = false;
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      // appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(state);
          return false;
        },
        child: SafeArea(
            child: FutureBuilder<Post?>(
          future: PostDbService().getPostById(widget.postId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Widget> imageSliders = snapshot.data!.photos!
                  .map((item) => Container(
                        height: 200,
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList();
              String keywords = '';
              for (var element in snapshot.data!.keywrds!) {
                keywords += ' ' + element;
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        (snapshot.data!.photos!.isNotEmpty)
                            ? CarouselSlider(
                                carouselController: _controller,
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                  autoPlay: true,
                                  // aspectRatio: 1.3,
                                  // aspectRatio: ,
                                  enlargeCenterPage: true,
                                ),
                                items: imageSliders,
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                child: const Center(
                                    child: Text(
                                  'لا يوجد صور',
                                  style: style1,
                                )),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: snapshot.data!.photos!.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : purple)
                                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                        TextRow(title: 'العنوان ', data: snapshot.data!.address),
                        TextRow(title: 'المحافظة ', data: snapshot.data!.city),
                        TextRow(title: 'حالة المنتج ', data: snapshot.data!.productStatus),
                        TextRow(title: 'السعر ', data: snapshot.data!.price + ' ل.س'),
                        TextRow(
                            title: 'التصنيف الفرعي ',
                            data: snapshot.data!.category1 + ' - ' + snapshot.data!.category2),
                        TextRow(title: 'الكلمات المفتاحية ', data: keywords),
                        const TextRow(title: 'الوصف ', data: ''),
                        TextRow(title: '', data: snapshot.data!.description),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('منتجات مشابهة',
                                style: TextStyle(
                                    color: purple, fontFamily: font, fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SimilerStuff(category: snapshot.data!.category1, postID: snapshot.data!.id!),
                      ],
                    ),
                    if (userModel != null)
                      Positioned(
                        left: 10,
                        top: MediaQuery.of(context).size.height * 0.47,
                        child: Column(
                          children: [
                            // (userModel!.id != snapshot.data!.userId)
                            //     ? InkWell(
                            //         onTap: () async {
                            //           //Start chat
                            //           await StreamChatService().createChannel(context, snapshot.data!.userId);
                            //         },
                            //         child: const Icon(
                            //           Icons.message,
                            //           color: white,
                            //           size: 25,
                            //         ),
                            //       )
                            //     : const SizedBox.shrink(),
                            (!loading)
                                ? FavourteWidget(
                                    postId: widget.postId!,
                                    userId: userModel!.id!,
                                    // userModel: userModel!,
                                    // isFavorite: widget.isFavorite,
                                  )
                                : const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                //send report
                                await ReportDbService().sendReport(snapshot.data!.id!, context);
                              },
                              child: const Icon(
                                Icons.report_gmailerrorred,
                                color: white,
                                size: 25,
                              ),
                            ),
                            const Text('ابلاغ',
                                style: TextStyle(
                                  color: white,
                                  fontFamily: font,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: purple),
              );
            }
            return const SizedBox.shrink();
          },
        )),
      ),
    );
  }
}

class FavourteWidget extends StatefulWidget {
  // UserModel userModel;
  final String postId;
  // bool isFavorite;
  final String userId;

  const FavourteWidget(
      {Key? key,
      required this.userId,
      //  required this.userModel, required this.isFavorite,
      required this.postId})
      : super(key: key);

  @override
  State<FavourteWidget> createState() => _FavourteWidgetState();
}

class _FavourteWidgetState extends State<FavourteWidget> {
  bool loading = false;
  late bool isfavorite = false;
  UserModel? userModel;

  Future<void> updateUser() async {
    userModel = await UserDbServices().getUser(widget.userId);
    setState(() {
      context.read<UserInfoProvider>().updateUerInfo(user: userModel!);
      isfavorite = userModel!.isFavouritePost(widget.postId);
      loading = false;
    });
  }

  @override
  void initState() {
    // isfavorite = widget.isFavorite;
    loading = true;
    updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(userModel!.isFavouritePost(widget.postId));
    return !loading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () async {
                if (userModel!.isFavouritePost(widget.postId)) {
                  loading = true;
                  setState(() {});
                  print('sssssss $loading');
                  await UserDbServices().removeFromFavourites(widget.postId);
                  await updateUser();
                  loading = false;
                  isfavorite = false;
                  setState(() {});
                } else {
                  loading = true;
                  setState(() {});
                  print('sssssss $loading');

                  await UserDbServices().addToFivourites(widget.postId);
                  await updateUser();
                  isfavorite = false;

                  loading = false;
                  setState(() {});
                }
              },
              child: userModel!.isFavouritePost(widget.postId)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 25,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      color: white,
                      size: 25,
                    ),
            ))
        : const SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              color: purple,
            ),
          );
  }
}
