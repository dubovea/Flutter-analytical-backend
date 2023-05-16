import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Заказы'),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: Order.orders.length,
                itemBuilder: (BuildContext context, index) {
                  return OrderdCard(order: Order.orders[index]);
                }),
          )
        ]));
  }
}

class OrderdCard extends StatelessWidget {
  final Order order;
  const OrderdCard({super.key, required this.order});

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
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(150, 40)),
                    child: const Text('Принять',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                ElevatedButton(
                    onPressed: () {},
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
