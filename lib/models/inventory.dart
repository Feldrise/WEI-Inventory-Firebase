import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  Inventory(this.id, {this.name, this.description});

  final String id;

  String name;
  String description;

  Inventory.fromMap(Map<String, dynamic> map, {this.id}) :
    name = map['name'] as String,
    description = map['description'] as String;

  Inventory.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, id: snapshot.reference.documentID);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'description': description
    };
  }
}