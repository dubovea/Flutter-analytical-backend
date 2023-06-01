import 'package:analytical_ecommerce_back/controllers/controllers.dart';
import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrderController orderController = Get.put(OrderController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Заказы'),
        ),
        body: Column(children: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: Align(
                  alignment: Alignment.topRight,
                  child: DropdownButtonExample())),
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: orderController.pendingOrders.length,
                  itemBuilder: (BuildContext context, index) {
                    return OrderdCard(
                        order: orderController.pendingOrders[index]);
                  }),
            ),
          )
        ]));
  }
}

class OrderdCard extends StatelessWidget {
  final Orders order;
  OrderdCard({super.key, required this.order});

  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    var products = Product.products
        .where((product) => order.productIds.contains(product.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ID заказа: ${order.id}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(DateFormat('dd-MM-yy').format(order.createdAt),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(products[index].name,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 280,
                              child: Text(
                                products[index].description,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Доставка',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('${order.delivery}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Цена',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('${order.total}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (order.isAccepted
                    ? ElevatedButton(
                        onPressed: () {
                          orderController.updateOrder(
                              order, 'isDelivered', !order.isDelivered);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(150, 40)),
                        child: const Text('Доставка',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)))
                    : ElevatedButton(
                        onPressed: () {
                          orderController.updateOrder(
                              order, 'isAccepted', !order.isAccepted);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(150, 40)),
                        child: const Text('Принять',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)))),
                ElevatedButton(
                    onPressed: () {
                      orderController.updateOrder(
                          order, 'isCanceled', !order.isCanceled);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(150, 40)),
                    child: const Text('Отклонить',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)))
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatelessWidget {
  DropdownButtonExample({super.key});
  final CategoriesController categoriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categoriesController.categories.value,
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<String>(
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {},
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
