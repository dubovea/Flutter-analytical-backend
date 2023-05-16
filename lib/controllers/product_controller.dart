import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:analytical_ecommerce_back/services/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();

  var products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];
  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductPrice(int index, Product product, double value) {
    product.price = value;
    products[index] = product;
  }

  void saveProductPrice(int index, Product product, double value) {
    database.updateProduct(product, 'price', value);
  }

  void updateProductQuantity(int index, Product product, int value) {
    product.quantity = value;
    products[index] = product;
  }

    void saveProductQuantity(int index, Product product, int value) {
    database.updateProduct(product, 'quantity', value);
  }
}
