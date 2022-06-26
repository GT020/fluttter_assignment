import 'package:bima_doctor_admin/app/app_constants.dart';
import 'package:bima_doctor_admin/app/route_constants.dart';
import 'package:bima_doctor_admin/providers/providers.dart';
import 'package:country_dial_code/country_dial_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final optAndLoginSwitchProvider =
    StateProvider.autoDispose<bool>((ref) => true);
final phoneTextEditingControllerProvider = Provider((ref) {
  return TextEditingController();
});
final otpTextEditingControllerProvider =
    Provider((ref) => TextEditingController());

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  String? verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;
  late final TextEditingController phoneTextController;
  late final TextEditingController otpTextController;

  String getCountryDialCode() {
    //get country code
    return CountryDialCode.fromCountryCode(
            WidgetsBinding.instance.window.locales.first.countryCode.toString())
        .dialCode;
  }

  Future<void> verifyPhone() async {
    print(phoneTextController.text);
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneTextController.text,
          codeAutoRetrievalTimeout: (String verId) {
            verificationId = verId;
          },
          codeSent: otpSent,
          timeout: const Duration(seconds: 5),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            debugPrint('Verification completed');
          },
          verificationFailed: (exception) {
            debugPrint('${exception.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  void otpSent(String verId, int? forceCodeResend) {
    verificationId = verId;

    ref.read(optAndLoginSwitchProvider.notifier).update((state) => !state);
  }

  void signIn() async {
    try {
      // ignore: unused_local_variable
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId.toString(),
          smsCode: otpTextController.text);
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      handleError(exception);
    }
  }

  void handleError(error) {
    debugPrint('${error.message}');
    switch (error.code) {
      case 'invalid-verification-code':
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  content: Text('Wrong Otp'),
                ));
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    phoneTextController = TextEditingController(text: getCountryDialCode());
    otpTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loginOtpSwitch = ref.watch(optAndLoginSwitchProvider);

    return Scaffold(
      backgroundColor: primary,
      body: loginOtpSwitch
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("ENTER YOUR MOBILE NUMBER",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: accent,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(maxHeight: 60),
                      suffix: IconButton(
                          onPressed: () {
                            phoneTextController.clear();
                          },
                          icon: const Icon(
                            Icons.close_sharp,
                            color: accent,
                          )),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    controller: phoneTextController,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    'We will send you a SMS with a verification code',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                MaterialButton(
                  onPressed: () {
                    verifyPhone();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 10),
                    decoration: BoxDecoration(
                        color: seaGreen,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ENTER VERIFICATION CODE",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                        color: accent,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 60),
                        suffix: IconButton(
                            onPressed: () {
                              otpTextController.clear();
                             },
                            icon: const Icon(
                              Icons.close_sharp,
                              color: accent,
                            )),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                      controller: otpTextController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      'Please enter the verification code sent to your mobile number ${phoneTextController.text}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  MaterialButton(
                    onPressed: () {
                      signIn();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                      decoration: BoxDecoration(
                          color: seaGreen,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
