import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:analytical_ecommerce_back/services/services.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController {
  final DatabaseService database = DatabaseService();
  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    stats.value = database.getOrderStats();
    super.onInit();
  }
}
