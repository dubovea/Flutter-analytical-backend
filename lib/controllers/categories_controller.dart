import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:analytical_ecommerce_back/services/services.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final DatabaseService database = DatabaseService();
  var categories = Future.value(<Category>[]).obs;

  @override
  void onInit() {
    categories.value = database.getCategories();
    super.onInit();
  }
}
