import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/views/register.page.dart';
import 'package:plasma/views/widgets/auth_button.dart';
import 'package:plasma/views/widgets/primary_button.widget.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    appname,
                    style: TextStyle(
                        fontFamily: GoogleFonts.orbitron().fontFamily),
                  ),
                  const Text(
                    "GET STARTED",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 150,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Enter your phone no. to join PLASMA !!",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 30,
                  ),
                  AuthInput(
                    label: "Phone Number",
                    preffix: "+91",
                    input: TextInputType.phone,
                    icon: CupertinoIcons.phone,
                    phoneController: phoneController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  PrimaryButton(
                    label: 'Continue Verification ',
                    callback: () {
                      _phoneVerification(phoneController, context, isLooading);
                    },
                  ),
                  const SizedBox(
                    height: 10,
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
                      "Sending Code...",
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

  Future _phoneVerification(TextEditingController phoneController,
      BuildContext context, ValueNotifier<bool> isLoading) async {
    if (phoneController.text.isNotEmpty && !isLoading.value) {
      isLoading.value = true;
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91 ${phoneController.text}",
        verificationCompleted: (credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          isLoading.value = false;
        },

        // when verification fails
        verificationFailed: (error) {
          isLoading.value = false;


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
                  Text("Some error occured! "),
                  Spacer(),
                  Text(
                    "try again",
                    style: TextStyle(color: primaryColor),
                    
                  )
                ],
              )));
        },
        timeout: const Duration(minutes: 2),
        codeSent: (verificationId, forceResendingToken) {
          isLoading.value = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpPage(
                  verificationId: verificationId,
                ),
              ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    }
  }
}
