import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:plasma_delivery/app/constants.dart';
import 'package:plasma_delivery/views/set_up.page.dart';
import 'package:plasma_delivery/views/widgets/primary_button.widget.dart';

class OtpPage extends StatefulHookWidget {
  const OtpPage({super.key, required this.verificationId});

  final String verificationId;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String code = '';
    final isLooading = useState(false);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.amber.withOpacity(0.2), Colors.white10],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appname,
                    style: TextStyle(fontFamily: GoogleFonts.syne().fontFamily),
                  ),
                  const Text(
                    "Enter OTP",
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 80,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Enter the code and begin the journey!",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width - 40,
                        child: OTPTextField(
                          onCompleted: (value) {
                            code = value;

                            try {
                              isLooading.value = true;
                              PhoneAuthCredential cred =
                                  PhoneAuthProvider.credential(
                                      verificationId: widget.verificationId,
                                      smsCode: code);
                              FirebaseAuth.instance
                                  .signInWithCredential(cred)
                                  .then((value) {
                                if (value.user != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SetUpPage(),
                                      ));
                                }
                              });
                            } catch (e) {
                              isLooading.value = false;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Iconsax.warning_2,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("Verfication Failed "),
                                          Spacer(),
                                          Text(
                                            "try again",
                                            style:
                                                TextStyle(color: primaryColor),
                                          )
                                        ],
                                      )));
                            }
                          },
                          fieldWidth: 40,
                          length: 6,
                          otpFieldStyle: OtpFieldStyle(
                            focusBorderColor: Colors.orange,
                          ),
                        )),
                  ),
                  Container(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PrimaryButton(
                    label: 'Verify',
                    callback: () {
                      try {
                        isLooading.value = true;
                        PhoneAuthCredential cred = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: code);
                        FirebaseAuth.instance
                            .signInWithCredential(cred)
                            .then((value) {
                          if (value.user != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SetUpPage(),
                                ));
                          }
                        });
                      } catch (e) {
                        isLooading.value = false;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Iconsax.warning_2,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Verfication Failed "),
                                Spacer(),
                                Text(
                                  "try again",
                                  style: TextStyle(color: primaryColor),
                                )
                              ],
                            )));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          if (isLooading.value)
            Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Verifing...",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
