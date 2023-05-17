import 'package:analytical_ecommerce_back/controllers/controllers.dart';
import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:analytical_ecommerce_back/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final OrderStatsController orderStatsController =
      Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My eCommerce'),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: orderStatsController.stats.value,
              builder: (BuildContext context,
                  AsyncSnapshot<List<OrderStats>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 250,
                    padding: const EdgeInsets.all(10),
                    child: CustomBarChart(
                      orderStats: snapshot.data!,
                    ),
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
              }),
          Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Перейти к продуктам'),
                  ),
                ),
              )),
          Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => OrdersScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Перейти к заказам'),
                  ),
                ),
              ))
        ],
      )),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key, required this.orderStats});

  final List<OrderStats> orderStats;
  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
        id: 'orders',
        data: orderStats,
        domainFn: (series, _) =>
            DateFormat.d().format(series.dateTime).toString(),
        measureFn: (series, _) => series.orders,
        colorFn: (series, _) => series.barColor!,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
