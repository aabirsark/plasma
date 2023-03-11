import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plasma_business/app/constants.dart';
import 'package:plasma_business/services/db/setup_commands.db.dart';
import 'package:plasma_business/views/main.page.dart';
import 'package:plasma_business/views/widgets/primary_button.widget.dart';
import 'package:plasma_business/views/widgets/primary_field.widget.dart';

class BusinessSetupPage extends HookWidget {
  const BusinessSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = useState('');
    final store = useTextEditingController();
    final about = useTextEditingController();
    final address = useTextEditingController();

    final isLoading = useState(false);
    final message = useState("Processing...");

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                maxHeight: MediaQuery.of(context).size.height * 2.5,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    "STORE SETUP",
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
                    "Begin your journey with PLASMA. Create your store now !",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? file = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 50);
                        if (file != null) {
                          imageUrl.value = file.path;
                        }
                      },
                      child: Container(
                        height: 170,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200),
                        child: imageUrl.value.isEmpty
                            ? Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Iconsax.add),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Add a banner")
                                  ],
                                ),
                              )
                            : Image.file(
                                File(imageUrl.value),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PrimaryField(
                    label: "Store Name",
                    input: TextInputType.name,
                    icon: Iconsax.shop,
                    controller: store,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryField(
                    label: "About your store",
                    input: TextInputType.name,
                    icon: Iconsax.personalcard,
                    controller: about,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryField(
                    label: "Address",
                    controller: address,
                    input: TextInputType.name,
                    icon: Iconsax.map,
                    helpertext:
                        "Add proper address which perfectly matches your location",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Your current location is taken as refrence",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                    label: 'Complete the process',
                    callback: () async {
                      if (store.text.isNotEmpty &&
                          address.text.isNotEmpty &&
                          about.text.isNotEmpty) {
                        isLoading.value = true;
                        message.value = "Uploading image...";
                        final imageDownload = await ProfileFunctions.uploadFile(
                            File(imageUrl.value));
                        if (imageDownload != null) {
                          message.value = "Setting up...";

                          ProfileFunctions.setUp(store.text, address.text,
                                  about.text, imageDownload)
                              .then((value) {
                            if (value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                  (route) => route.isFirst);
                              isLoading.value = false;
                            }
                          });
                        }
                      } else {
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
                                Text("All Fields are required"),
                              ],
                            )));
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
          if (isLoading.value)
            Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      message.value,
                      style: const TextStyle(color: Colors.white),
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
