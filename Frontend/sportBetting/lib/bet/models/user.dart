import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User {
  String id;
  String password;
  String username;
  double balance;

  User(
      {this.id,
      @required this.password,
      @required this.username,
      this.balance});

  List<Object> get props => [id, password, username, balance];

  @override
  String toString() =>
      'User {id: $id, password: $password,email: $username, balance: $balance}';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['public_id'],
        username: json['username'],
        password: json['password'],
        balance: json['balance']);
  }
}
