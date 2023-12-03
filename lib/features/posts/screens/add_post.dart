import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/features/auth/Providers/auth_state_provider.dart';
import 'package:lets_buy/features/auth/Services/file_services.dart';
import 'package:lets_buy/features/posts/models/post.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/home_screen/widgets/custom_navigation_bar.dart';
import 'package:lets_buy/core/config/widgets/drop_down_custom.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/picked_images_widget.dart';
import 'package:lets_buy/core/config/widgets/text_field_custome.dart';
import 'package:lets_buy/features/home_screen/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  static const String routeName = '/add_post';
  const AddPostScreen({Key? key}) : super(key: key);
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool isSwitched = true;
  List<String> category1 = categories.keys.toList();
  List<String> category2 = [];
  String selectedCategory1 = 'اختر';
  String selectedCategory2 = 'اختر';
  String productStatus = 'جديد';
  String symbol = 'Ls';
  bool visible = false;
  String postType = 'حمص';
  List<XFile> pickedimages = [];

  _pickImage() async {
    final picker = ImagePicker();
    try {
      var picked = await picker.pickMultiImage();
      if (picked.isNotEmpty) {
        pickedimages.addAll(picked);

        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    category2 = categories[selectedCategory1]!;

    return Scaffold(
      backgroundColor: dark,
      bottomNavigationBar: CustomNavigationBar(index: 0),
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0.0,
        title: const Text('اضافة منشور', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 0, 100, 10),
            child: InkWell(
              onTap: () {
                _pickImage();
                setState(() {});
              },
              child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: purple),
                    color: dark,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: white,
                    size: 30,
                  )),
            ),
          ),
          (pickedimages.isNotEmpty)
              ? SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return PickedImagesWidget(
                        url: File(pickedimages[i].path),
                        onTap: () {
                          pickedimages.removeAt(i);
                          setState(() {});
                        },
                      );
                    },
                    itemCount: pickedimages.length,
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 20, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Text('متاح', style: style1),
                      const SizedBox(width: 10),
                      FlutterSwitch(
                          value: isSwitched,
                          height: 30,
                          width: 50,
                          toggleSize: 20,
                          borderRadius: 50,
                          activeColor: dark,
                          inactiveColor: white,
                          toggleColor: purple,
                          switchBorder: Border.all(
                            color: purple,
                          ),
                          onToggle: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          }),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DropDownCustom(
                    categories: productStatusList,
                    selectedItem: productStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        productStatus = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DropDownCustom(
                categories: cities,
                selectedItem: postType,
                onChanged: (String? newValue) {
                  setState(() {
                    postType = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DropDownCustom(
                    categories: category1,
                    selectedItem: selectedCategory1,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory1 = newValue!;
                        selectedCategory2 =
                            categories[selectedCategory1]!.first;
                        visible = true;
                      });
                    },
                  ),
                ),
              ),
              (visible)
                  ? Expanded(
                      child: DropDownCustom(
                        categories: category2,
                        selectedItem: selectedCategory2,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory2 = newValue!;
                          });
                        },
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              title('العنوان'),
              Expanded(
                  child:
                      TextFieldCustom(text: '', controller: addressController)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              title('السعر'),
              Expanded(
                  child: TextFieldCustom(
                text: '',
                controller: priceController,
                keyboardType: TextInputType.number,
              )),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 10),
                // decoration: BoxDecoration(border: Border.all(color: purple), borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  children: [
                    Text(
                      'ل.س',
                      style: style2,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              title('الوصف'),
              Expanded(
                  child: TextFieldCustom(
                text: '',
                controller: descController,
                maxLine: 8,
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              title('كلمات مفتاحية'),
              Expanded(
                  child: TextFieldCustom(text: '', controller: tagsController))
            ],
          ),
          const SizedBox(height: 20),
          Consumer<AuthSataProvider>(builder: (context, value, child) {
            return Center(
                child: (value.authState == AuthState.notSet)
                    ? ElevatedButtonCustom(
                        text: 'اضافة',
                        color: purple,
                        onPressed: () async {
                          if (selectedCategory1 == 'اختر' ||
                              selectedCategory2 == 'اختر') {
                            var snackBar = const SnackBar(
                              content: Text(
                                'الرجاء اختيار تصنيف',
                                style: style2,
                              ),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          //change the state to loading
                          Provider.of<AuthSataProvider>(context, listen: false)
                              .changeAuthState(newState: AuthState.waiting);
                          // split the tags and add them to the list
                          List<String> keywords =
                              tagsController.text.split(' ').toList();

                          String uid = FirebaseAuth.instance.currentUser!.uid;

                          List<String> images = [];
                          //upload the images to firebase storage and get the urls
                          images = await FileService()
                              .uploadeimages(pickedimages, context);
                          //upload the post to firebase database
                          if (images.isNotEmpty) {
                            Post post = Post(
                                address: addressController.text,
                                category1: selectedCategory1,
                                category2: selectedCategory2,
                                productStatus: productStatus,
                                description: descController.text,
                                isAvailable: isSwitched,
                                price: priceController.text,
                                symbol: symbol,
                                city: postType,
                                userId: uid,
                                keywrds: keywords,
                                photos: images);

                            await PostDbService().addPost(post, context);
                            //change the state to notSet
                            Provider.of<AuthSataProvider>(context,
                                    listen: false)
                                .changeAuthState(newState: AuthState.notSet);
                            SnackBar snackBar = const SnackBar(
                                content: Text('تمت الاضافة بنجاح'));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.routeName, (route) => false);
                          } else {
                            SnackBar snackBar = const SnackBar(
                                content: Text(
                                    'حدثت مشكلة اثناء تحميل الصور, الرجاء المحاولة لاحقاً'));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        })
                    : const CircularProgressIndicator(
                        color: purple,
                      ));
          })
        ],
      ),
    );
  }

  title(String title) {
    return SizedBox(
      width: 80,
      child: Text(
        title,
        style: style1,
      ),
    );
  }
}
