import 'package:analytical_ecommerce_back/controllers/controllers.dart';
import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownCategories extends StatelessWidget {
  DropdownCategories({super.key});
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categoriesController.categoriesProducts.value,
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Категория продукта',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              isDense: true,
              icon: const Icon(Icons.arrow_downward),
              style: const TextStyle(fontSize: 16, color: Colors.black),
              underline: Container(
                height: 3,
                color: Colors.black,
              ),
              value: productController.newProduct['category'],
              onChanged: (String? value) {
                productController.newProduct.update(
                  'category',
                  (_) => value,
                  ifAbsent: () => value,
                );
              },
              items: snapshot.data!
                  .map<DropdownMenuItem<String>>((Category category) {
                return DropdownMenuItem<String>(
                  value: category.name,
                  child: Text(category.name),
                );
              }).toList(),
            );
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}
