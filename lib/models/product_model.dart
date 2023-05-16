import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final bool isRecommended;
  final bool isPopular;
  double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.isRecommended,
    required this.isPopular,
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        description,
        imageUrl,
        isRecommended,
        isPopular,
        price,
        quantity
      ];

  Product copyWith(
      {int? id,
      String? name,
      String? category,
      String? description,
      String? imageUrl,
      bool? isRecommended,
      bool? isPopular,
      double? price,
      int? quantity}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isRecommended: isRecommended ?? this.isRecommended,
      isPopular: isPopular ?? this.isPopular,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'price': price,
      'quantity': quantity
    };
  }

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
      id: snapshot['id'],
      name: snapshot['name'],
      category: snapshot['category'],
      description: snapshot['description'],
      imageUrl: snapshot['imageUrl'],
      isRecommended: snapshot['isRecommended'],
      isPopular: snapshot['isPopular'],
      price: snapshot['price'],
      quantity: snapshot['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  static List<Product> products = [
    Product(
        id: 1,
        description:
            'Pepsi — газированный безалкогольный напиток, производимый компанией PepsiCo. Создан в 1893 году Калебом Брэдхемом под названием «Напиток Брэда». В 1898 году переименован в Pepsi-Cola, а затем сокращён до Pepsi в 1961 году.',
        name: 'PEPSI',
        imageUrl:
            'https://c.ndtvimg.com/2022-01/mg0fne68_pepsi_625x300_05_January_22.jpg?im=FeatureCrop,algorithm=dnn,width=620,height=350',
        price: 2.99,
        isRecommended: true,
        isPopular: true,
        category: 'Soft Drinks'),
    Product(
        id: 2,
        description:
            'Pepsi — газированный безалкогольный напиток, производимый компанией PepsiCo. Создан в 1893 году Калебом Брэдхемом под названием «Напиток Брэда». В 1898 году переименован в Pepsi-Cola, а затем сокращён до Pepsi в 1961 году.',
        name: 'COCA COLA',
        imageUrl:
            'https://sun9-53.userapi.com/impg/tGWbpy5unaNqjDd473U0p4S9f9I2IjMMWkG5Ew/fN-67csrgZs.jpg?size=807x538&quality=95&sign=4bf42db3b10d9db46013d544847cdf88&type=album',
        price: 1.44,
        isRecommended: true,
        isPopular: true,
        category: 'Soft Drinks'),
    Product(
        id: 3,
        description:
            'Фа́нта — безалкогольный сильногазированный прохладительный напиток с цитрусовым вкусом; выпускается корпорацией Coca-Cola. Основной вариант вкуса — апельсиновый; в разных странах также выпускаются различные вкусовые варианты, например, в России по состоянию на 2021 год выпускаются вкусы апельсина, мангуавы, шоката.',
        name: 'FANTA',
        imageUrl:
            'https://kupivody.ru/wp-content/uploads/2022/06/fantamango0355banka.jpeg',
        price: 2.58,
        isRecommended: true,
        isPopular: false,
        category: 'Soft Drinks'),
  ];
}
