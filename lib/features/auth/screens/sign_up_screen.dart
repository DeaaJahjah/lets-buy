import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/text_field_custome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_buy/features/auth/Services/file_services.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
import 'package:lets_buy/features/auth/screens/verfiy_phone_number_screen.dart';
import 'package:path/path.dart' as path;

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign_up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  _pickImage() async {
    final picker = ImagePicker();
    try {
      pickedimage = await picker.pickImage(source: ImageSource.gallery);
      fileName = path.basename(pickedimage!.path);
      imageFile = File(pickedimage!.path);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('انشاء حساب', style: appBarTextStyle),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              children: [
                InkWell(
                  onTap: () {
                    _pickImage();
                    setState(() {});
                  },
                  child: CircleAvatar(
                    backgroundColor: purple,
                    radius: 57,
                    child: (pickedimage == null)
                        ? const CircleAvatar(
                            backgroundColor: dark,
                            radius: 55,
                            child: Icon(Icons.person, size: 70, color: white),
                          )
                        : CircleAvatar(
                            radius: 60, backgroundImage: FileImage(imageFile!)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(
                    text: 'اسم المستخدم',
                    controller: userName,
                    icon: Icons.person),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(
                    text: 'رقم الهاتف',
                    controller: phoneController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(
                    text: 'البريد الإلكتروني',
                    controller: email,
                    icon: Icons.email),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(
                    text: 'عنوان السكن',
                    controller: address,
                    icon: Icons.location_on),
                const SizedBox(
                  height: 24,
                ),
                !isLoading
                    ? ElevatedButtonCustom(
                        color: purple,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (imageFile == null) {
                              var snackBar = const SnackBar(
                                  content: Text('الرجاء اخيار صورة'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }

                            //TODO:: login by firebase

                            setState(() {
                              isLoading = true;
                            });

                            String url = '';

                            if (imageFile != null) {
                              url = await FileService()
                                  .uploadeimage(fileName, imageFile!, context);

                              if (url != 'error') {
                                UserModel user = UserModel(
                                    name: userName.text,
                                    phoneNumber: phoneController.text,
                                    email: email.text,
                                    address: address.text,
                                    imgUrl: url);

                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context).pushNamed(
                                    VerfiyPhoneNumberScree.routeName,
                                    arguments: user.toJson());
                              }
                            }
                          } else {
                            var snackBar = const SnackBar(
                                content: Text('جميع الحقول مطلوبة'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        text: 'انشاء',
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                        color: purple,
                      )),
              ]),
        ),
      ),
    );
  }
}
