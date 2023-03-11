import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma_business/services/db/setup_commands.db.dart';
import 'package:plasma_business/services/models/shop_info.model.dart';
import 'package:plasma_business/views/business_setup.page.dart';
import 'package:plasma_business/views/login.page.dart';
import 'package:plasma_business/views/widgets/primary_button.widget.dart';

class ShopInfoPage extends StatefulWidget {
  const ShopInfoPage({super.key});

  @override
  State<ShopInfoPage> createState() => _ShopInfoPageState();
}

class _ShopInfoPageState extends State<ShopInfoPage> {
  bool isLoading = true;
  ShopInfoModel? model;

  @override
  void initState() {
    super.initState();
    ProfileFunctions.getProfile().then((value) {
      setState(() {
        model = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Shop Info"),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                ),
              )
            : model != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey.shade200,
                          child: Image.network(
                            model!.banner!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                (model?.shop ?? "").toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                model?.about ?? "",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(model?.address ?? ""),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Phone",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const Icon(Iconsax.call),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(model?.phone ?? "")
                                ],
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              PrimaryButton(
                                callback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const BusinessSetupPage(),
                                      ));
                                },
                                customWidget: const Text(
                                  "Edit Details",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ));
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 20.0),
                                        child: Text(
                                          "Logout",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: Text("An error occured !"),
                  ),
      ),
    );
  }
}
