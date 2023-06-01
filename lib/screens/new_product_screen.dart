import 'package:analytical_ecommerce_back/controllers/controllers.dart';
import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:analytical_ecommerce_back/services/services.dart';
import 'package:analytical_ecommerce_back/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({super.key});
  final ProductController productController = Get.find();
  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Добавить продукт'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Card(
                        margin: EdgeInsets.zero,
                        color: Colors.black,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  ImagePicker _picker = ImagePicker();
                                  final XFile? _image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (_image == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Изображение не выбрано')));
                                    return;
                                  }

                                  await storage.uploadImage(_image);
                                  String imageUrl =
                                      await storage.getDownloadURL(_image.name);
                                  productController.newProduct.update(
                                      'imageUrl', (_) => imageUrl,
                                      ifAbsent: () => imageUrl);
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                )),
                            const Text('Добавить изображение',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                  ),
                  const SizedBox(height: 20),
                  const Text('Информация о продукте',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  _buildTextFormField('ID продукта', 'id', productController),
                  _buildTextFormField(
                      'Наименование продукта', 'name', productController),
                  _buildTextFormField(
                      'Описание продукта', 'description', productController),
                  Column(
                    children: [
                      SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: DropdownCategories())
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildSlider('Цена', 'price', productController,
                      productController.price),
                  _buildSlider('Количество', 'quantity', productController,
                      productController.quantity),
                  const SizedBox(height: 10),
                  _buildCheckbox('Рекоммендуется', 'isRecommended',
                      productController, productController.isRecommended),
                  _buildCheckbox('Популярное', 'isPopular', productController,
                      productController.isPopular),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        database.addProduct(
                          Product(
                            id: int.parse(productController.newProduct['id']),
                            name: productController.newProduct['name'],
                            category: productController.newProduct['category'],
                            description:
                                productController.newProduct['description'],
                            imageUrl: productController.newProduct['imageUrl'],
                            isRecommended:
                                productController.newProduct['isRecommended'],
                            isPopular:
                                productController.newProduct['isPopular'],
                            price: productController.newProduct['price'],
                            quantity: productController.newProduct['quantity']
                                .toInt(),
                          ),
                        );
                      },
                      child: const Text('Сохранить',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            )));
  }

  Row _buildCheckbox(
    String label,
    String fieldName,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(label,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
        Checkbox(
            value: controllerValue ?? false,
            checkColor: Colors.black,
            activeColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                fieldName,
                (_) => value,
                ifAbsent: () => value,
              );
            }),
      ],
    );
  }

  Row _buildSlider(
    String label,
    String fieldName,
    ProductController productController,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Slider(
                  min: 0,
                  max: 25,
                  divisions: 10,
                  activeColor: Colors.black,
                  inactiveColor: Colors.black12,
                  value: controllerValue ?? 0,
                  onChanged: (value) {
                    productController.newProduct.update(
                      fieldName,
                      (_) => value,
                      ifAbsent: () => value,
                    );
                  }),
              Text(productController.newProduct[fieldName].toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        )
      ],
    );
  }

  TextFormField _buildTextFormField(
    String hintText,
    String fieldName,
    ProductController productController,
  ) {
    return TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onChanged: (value) {
          productController.newProduct.update(
            fieldName,
            (_) => value,
            ifAbsent: () => value,
          );
        });
  }
}
