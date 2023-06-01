import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  @override
  Category copyWith({
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    return Category(
      id: snapshot['id'],
      name: snapshot['name'],
    );
  }

  String toJson() => json.encode(toMap());

  List<Object?> get props => [
        id,
        name,
      ];
}
