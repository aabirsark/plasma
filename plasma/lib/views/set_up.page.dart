import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/views/home.page.dart';
import 'package:plasma/views/widgets/auth_button.dart';
import 'package:plasma/views/widgets/primary_button.widget.dart';

class SetUpPage extends HookWidget {
  const SetUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
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
                style: TextStyle(fontFamily: GoogleFonts.orbitron().fontFamily),
              ),
              const Text(
                "YOUR NAME",
                style: TextStyle(
                  fontSize: 40,
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
                "what should we call you ?",
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 30,
              ),
              AuthInput(
                label: "Full Name",
                input: TextInputType.name,
                icon: CupertinoIcons.person,
                phoneController: name,
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                label: 'Explore Plasma',
                callback: () {
                  if (name.text.isNotEmpty) {
                    FirebaseAuth.instance.currentUser!
                        .updateDisplayName(name.text);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => route.isFirst);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Complete the field")));
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
