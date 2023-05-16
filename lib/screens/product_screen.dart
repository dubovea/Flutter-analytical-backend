import 'package:analytical_ecommerce_back/controllers/controllers.dart';
import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:analytical_ecommerce_back/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список продуктов'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          SizedBox(
            height: 100,
            child: Card(
                margin: EdgeInsets.zero,
                color: Colors.black,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(() => NewProductScreen());
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        )),
                    const Text('Добавить продукт',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                  ],
                )),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 210,
                    child: ProductCard(
                        index: index,
                        product: productController.products[index]),
                  );
                })),
          )
        ]),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  final ProductController productController = Get.find();
  ProductCard({required this.index, required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(children: [
            Text(product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(product.description,
                style: const TextStyle(
                  fontSize: 12,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(product.imageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text('Цена',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              min: 0,
                              max: 25,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              value: product.price,
                              onChanged: (value) {
                                productController.updateProductPrice(
                                    index, product, value);
                              },
                              onChangeEnd: (value) {
                                productController.saveProductPrice(
                                    index, product, value);
                              },
                            ),
                          ),
                          Text('\$${product.price.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text('Кол.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              min: 0,
                              max: 100,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              value: product.quantity.toDouble(),
                              onChanged: (value) {
                                productController.updateProductQuantity(
                                    index, product, value.toInt());
                              },
                              onChangeEnd: (value) {
                                productController.saveProductQuantity(
                                    index, product, value);
                              },
                            ),
                          ),
                          Text('${product.quantity.toInt()}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ]),
        ));
  }
}
