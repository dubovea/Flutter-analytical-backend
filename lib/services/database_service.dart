import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  Future<List<OrderStats>> getOrderStats() {
    return _firebaseStore.collection('order_stats').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) => OrderStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  Stream<List<Orders>> getOrders() {
    return _firebaseStore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Orders.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Orders>> getPendingOrders() {
    return _firebaseStore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCanceled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Orders.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updateOrder(
    Orders order,
    String fieldName,
    bool newValue,
  ) {
    return _firebaseStore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({fieldName: newValue})
            });
  }

  Stream<List<Product>> getProducts() {
    return _firebaseStore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return _firebaseStore.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(
    Product product,
    String fieldName,
    dynamic newValue,
  ) {
    return _firebaseStore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({fieldName: newValue})
            });
  }
}
