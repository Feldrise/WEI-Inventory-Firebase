import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.firstName, this.secondName, this.email});

  String id;

  final String firstName;
  final String secondName;
  final String email;

  User.fromMap(Map<String, dynamic> map, {this.id}) :
    firstName = map['first_name'] as String,
    secondName = map['second_name'] as String,
    email = map['email'] as String;

  User.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, id: snapshot.reference.documentID);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'first_name': firstName,
      'second_name': secondName,
      'email': email
    };
  }
}