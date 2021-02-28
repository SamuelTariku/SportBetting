import 'package:flutter/material.dart';

class User {
  int id;
  String password;
  String email;

  User({this.id, @required this.password, @required email});

  @override
  List<Object> get props => [id,password,email];

  @override
  String toString() => 'User {id: $id, password: $password,email: $email}';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }
}