import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String categoryId;
  final String categoryName;

  const Category({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Category copyWith({
    String? categoryId,
    String? categoryName,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return {'categoryId': categoryId, 'categoryName': categoryName};
  }

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    return Category(
      categoryId: snapshot['categoryId'],
      categoryName: snapshot['categoryName'],
    );
  }

  String toJson() => json.encode(toMap());

  List<Object?> get props => [
        categoryId,
        categoryName,
      ];
}
