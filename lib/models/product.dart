import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product(this.id, {this.quantity, this.name, this.description});

  final String id;

  int quantity;
  String name;
  String description;

  Product.fromMap(Map<String, dynamic> map, {this.id}) :
    quantity = map['quantity'] as int,
    name = map['name'] as String,
    description = map['description'] as String;

  Product.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, id: snapshot.reference.documentID);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'quantity': quantity,
      'name': name,
      'description': description
    };
  }
}