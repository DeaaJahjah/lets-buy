import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/widgets/custom_progress.dart';
import 'package:lets_buy/core/config/widgets/custom_snackbar.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerfiyPhoneNumberScree extends StatefulWidget {
  static const routeName = '/verfiy-phone-number';
  const VerfiyPhoneNumberScree({Key? key}) : super(key: key);

  @override
  State<VerfiyPhoneNumberScree> createState() => _VerfiyPhoneNumberScreeState();
}

class _VerfiyPhoneNumberScreeState extends State<VerfiyPhoneNumberScree> {
  final otpController = TextEditingController();

  bool isLoading = false;
  bool isLoadingOTP = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationIDFromFirebase;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final user = UserModel.fromJson(
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
      isLoading = true;
      setState(() {});
      try {
        await auth.verifyPhoneNumber(
          phoneNumber: '+966 ${user.phoneNumber}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (error) {
            setState(() {
              isLoading = false;
            });
            showErrorSnackBar(context, '${error.message}');
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              isLoading = false;
              verificationIDFromFirebase = verificationId;
              print(verificationId);
            });
          },
        );
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        isLoading = false;

        showErrorSnackBar(context, e.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'تأكيد رقم الهاتف',
            style: TextStyle(fontSize: 16),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100.0,
              ),
              Text('ادخل رمز التأكيد',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: pink)),
              const SizedBox(
                height: 20.0,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PinCodeTextField(
                    appContext: context,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    autoFocus: true,
                    autoUnfocus: true,
                    // backgroundColor: primaryColor,
                    enableActiveFill: true,

                    pinTheme: PinTheme(
                        inactiveFillColor: purple,
                        inactiveColor: purple,
                        activeFillColor: pink,
                        activeColor: purple,
                        selectedFillColor: purple,
                        selectedColor: purple),
                    boxShadows: const [
                      BoxShadow(
                          offset: Offset(-2, 2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          color: Colors.black54)
                    ],
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    onChanged: (value) {},
                    onCompleted: (value) {
                      _verifyOTPButton();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              isLoadingOTP == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButtonCustom(
                        color: purple,
                        text: 'موافق',
                        onPressed: () => _verifyOTPButton(),
                      ),
                    )
                  : const CustomProgress(),
            ],
          ),
        ),
      ),
    );
  }

  _verifyOTPButton() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationIDFromFirebase,
        smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      isLoadingOTP = true;
    });
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        if (mounted) {
          await UserDbServices().creatUser(
              UserModel.fromJson(ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>),
              context);

          setState(() {
            isLoadingOTP = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoadingOTP = false;
      });
      showErrorSnackBar(context, 'رمز التحقق غير صحيح');
    }
  }
}
