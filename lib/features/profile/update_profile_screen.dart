import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/text_field_custome.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/features/auth/Providers/auth_state_provider.dart';
import 'package:lets_buy/features/auth/Services/file_services.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/update_profile_screen';
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  XFile? pickedimage;
  bool firstTime = false;
  String fileName = '';
  File? imageFile;
  String oldImage = '';
  var formKey = GlobalKey<FormState>();
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
  void didChangeDependencies() {
    final UserModel user = ModalRoute.of(context)?.settings.arguments as UserModel;
    if (!firstTime) {
      userName.text = user.name;
      email.text = user.email;
      address.text = user.address;
      oldImage = user.imgUrl;
      phoneController.text = user.phoneNumber;
      firstTime = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('تعديل الملف الشخصي', style: appBarTextStyle),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: ListView(padding: const EdgeInsets.fromLTRB(20, 5, 20, 0), children: [
            InkWell(
              onTap: () {
                _pickImage();
                setState(() {});
                print(imageFile);
              },
              child: CircleAvatar(
                backgroundColor: purple,
                radius: 57,
                child: (pickedimage == null)
                    ? CircleAvatar(
                        backgroundColor: dark,
                        radius: 55,
                        backgroundImage: NetworkImage(oldImage),
                      )
                    : CircleAvatar(radius: 60, backgroundImage: FileImage(imageFile!)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(text: 'اسم المستخدم', controller: userName, icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(
                text: 'رقم الهاتف', controller: phoneController, icon: Icons.phone, keyboardType: TextInputType.phone),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(text: 'البريد الإلكتروني', controller: email, icon: Icons.email),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldCustom(text: 'العنوان', controller: address, icon: Icons.location_on),
            const SizedBox(
              height: 24,
            ),
            Consumer<AuthSataProvider>(
                builder: (context, state, child) => (state.authState == AuthState.notSet)
                    ? ElevatedButtonCustom(
                        color: purple,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (confirmPassword.text == password.text) {
                              String url = oldImage;
                              state.changeAuthState(newState: AuthState.waiting);
                              if (imageFile != null) {
                                url = await FileService().uploadeimage(fileName, imageFile!, context);
                              }

                              if (url != 'error') {
                                UserModel user = UserModel(
                                    name: userName.text,
                                    email: email.text,
                                    phoneNumber: phoneController.text,
                                    address: address.text,
                                    imgUrl: url);
                                await UserDbServices().updateUser(user, context);
                                state.changeAuthState(newState: AuthState.notSet);

                                var snackBar = const SnackBar(content: Text('تم تعديل الملف الشخصي بنجاح'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                Navigator.of(context).pop();
                              } else {
                                state.changeAuthState(newState: AuthState.notSet);

                                var snackBar = const SnackBar(content: Text('حدث خطأ, الرجاء المحاولة لاحقاً'));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            }
                          } else {
                            var snackBar = const SnackBar(content: Text('جميع الحقول مطلوبة'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                          }
                        },
                        text: 'موافق',
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                        color: purple,
                      ))),
          ]),
        ),
      ),
    );
  }
}
