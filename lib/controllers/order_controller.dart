import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:analytical_ecommerce_back/services/services.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final DatabaseService database = DatabaseService();
  var orders = <Orders>[].obs;
  var pendingOrders = <Orders>[].obs;

  @override
  void onInit() {
    orders.bindStream(database.getOrders());
    pendingOrders.bindStream(database.getPendingOrders());
    super.onInit();
  }

  void updateOrder(Orders order, String fieldName, bool value) {
    database.updateOrder(order, fieldName, value);
  }
}
