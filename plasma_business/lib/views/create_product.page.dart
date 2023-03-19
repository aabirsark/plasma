import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plasma_business/services/db/product_functions.db.dart';
import 'package:plasma_business/services/models/product_model.dart';
import 'package:plasma_business/views/widgets/primary_button.widget.dart';
import 'package:plasma_business/views/widgets/primary_field.widget.dart';

class CreateProduct extends HookWidget {
  const CreateProduct({super.key, this.model});

  final ProductModel? model;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<String>> images = useState([]);

    final name = useTextEditingController(text: model?.product);
    final description = useTextEditingController(text: model?.about);
    final price = useTextEditingController(text: model?.price.toString());
    final isloading = useState(false);
    final loadingMessage = useState("Processing...");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(model != null ? "Update product" : "Add products"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (images.value.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Swipe to see more"),
                    ),
                  if (model == null)
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        List<XFile> file =
                            await picker.pickMultiImage(imageQuality: 60);

                        images.value = file.map((e) => e.path).toList();
                      },
                      child: Container(
                        height: 230,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200),
                        child: images.value.isEmpty
                            ? Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Iconsax.add,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Add Images",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            : PageView.builder(
                                itemCount: images.value.length,
                                itemBuilder: (context, index) => Image.file(
                                  File(images.value[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryField(
                    label: "Product Name",
                    input: TextInputType.name,
                    icon: Iconsax.box,
                    maxlines: 2,
                    controller: name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PrimaryField(
                    label: "Product description",
                    input: TextInputType.name,
                    icon: Iconsax.info_circle,
                    controller: description,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryField(
                          controller: price,
                          label: "Product Price",
                          input: TextInputType.number,
                          icon: FontAwesomeIcons.rupeeSign,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        decoration: ShapeDecoration(
                            shape: const StadiumBorder(),
                            color: Colors.amber.withOpacity(0.3)),
                        child: const Text(
                          "/ 250 gm",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Make the cost which agrees to the 250 gm weightage",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  PrimaryButton(
                    callback: () {
                      if (images.value.isNotEmpty &&
                          name.text.isNotEmpty &&
                          description.text.isNotEmpty &&
                          price.text.isNotEmpty) {
                        isloading.value = true;

                        loadingMessage.value = "Uploading images...";
                        ProductFuctions.uploadImages(images.value)
                            .then((value) {
                          print(value);
                          if (value.isNotEmpty) {
                            loadingMessage.value = "Setting up the product";

                            ProductFuctions.addProduct(
                                    name.text,
                                    description.text,
                                    double.parse(price.text),
                                    value)
                                .then((value) {
                              if (value) {
                                Navigator.pop(context);
                              }
                              isloading.value = false;
                            });
                          }
                        });
                      }
                    },
                    customWidget: const Center(
                      child: Text(
                        "Add Product to market",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          if (isloading.value)
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
                      loadingMessage.value,
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
