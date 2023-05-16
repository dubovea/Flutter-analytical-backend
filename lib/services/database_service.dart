import 'package:analytical_ecommerce_back/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

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
