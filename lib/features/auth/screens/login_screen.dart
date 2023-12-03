import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/config/widgets/custom_progress.dart';
import 'package:lets_buy/core/config/widgets/custom_snackbar.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/text_field_custome.dart';
import 'package:lets_buy/features/auth/screens/sign_up_screen.dart';
import 'package:lets_buy/features/home_screen/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/log_in';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNumcontroller = TextEditingController();

  final otpController = TextEditingController();

  bool isLoading = false;
  bool isLoadingOTP = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationIDFromFirebase;
  PhoneVerificationState currentState =
      PhoneVerificationState.SHOW_PHONE_FORM_STATE;
  @override
  Widget build(BuildContext context) {
    return currentState == PhoneVerificationState.SHOW_PHONE_FORM_STATE
        ? Scaffold(
            backgroundColor: dark,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedBoxLarge,
                    Image.asset(
                      'assets/images/logo.png',
                      height: MediaQuery.sizeOf(context).height * 0.25,
                    ),
                    sizedBoxSmall,
                    const Text(
                      'Let\'s Buy',
                      style: TextStyle(fontSize: 24),
                    ),
                    sizedBoxLarge,
                    TextFieldCustom(
                        keyboardType: TextInputType.number,
                        text: 'أدخل رقم الهاتف',
                        controller: phoneNumcontroller),
                    sizedBoxLarge,
                    isLoading
                        ? const CustomProgress()
                        : ElevatedButtonCustom(
                            color: purple,
                            text: 'تسجيل دخول',
                            onPressed: () async {
                              isLoading = true;
                              setState(() {});
                              if (phoneNumcontroller.text.length != 9) {
                                showErrorSnackBar(context,
                                    'يجب ان يكون رقم الهاتف تسع أرقام');

                                isLoading = false;
                                setState(() {});
                                return;
                              }

                              try {
                                await auth.verifyPhoneNumber(
                                  phoneNumber:
                                      '+966 ${phoneNumcontroller.text}',
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) async {
                                    // ANDROID ONLY!

                                    // Sign the user in (or link) with the auto-generated credential
                                    await auth.signInWithCredential(credential);

                                    // Navigator.of(context).pushNamed(PersonalData.routeName);
                                  },
                                  verificationFailed: (error) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showErrorSnackBar(
                                        context, '${error.message}');
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                  codeSent:
                                      (verificationId, resendingToken) async {
                                    setState(() {
                                      isLoading = false;
                                      currentState = PhoneVerificationState
                                          .SHOW_OTP_FORM_STATE;
                                      verificationIDFromFirebase =
                                          verificationId;
                                    });
                                  },
                                );
                                // setState(() {
                                //   isLoading = false;
                                // });
                              } catch (e) {
                                isLoading = false;

                                showErrorSnackBar(context, e.toString());
                              }
                            }),
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(
                              color: white, fontSize: 16, fontFamily: font),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          child: const Text('انضم الينا',
                              style: TextStyle(
                                  color: purple,
                                  fontSize: 16,
                                  fontFamily: font,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignUpScreen.routeName);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : getOTPFormWidget();
  }

  getOTPFormWidget() {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("تأكيد رقم الهاتف")),
      body: SafeArea(
        child: Column(
          children: [
            // const Text(
            //   "ادخل رمز التحقق",
            //   style: TextStyle(fontSize: 16.0),
            // ),
            const SizedBox(
              height: 100.0,
            ),
            Text('ادخل رمز التأكيد',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: white)),
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
            !isLoadingOTP
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
        setState(() {
          isLoadingOTP = false;
        });
        final client = StreamChatCore.of(context).client;
        await client.connectUser(OwnUser(id: authCredential.user!.uid),
            authCredential.user!.displayName!);

        // User(id: authCredential.user!.uid), authCredential.user!.displayName!

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

        // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException {
      setState(() {
        isLoadingOTP = false;
      });
      showErrorSnackBar(context, 'رمز التحقق غير صحيح');
    }
  }
}
