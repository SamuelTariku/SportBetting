import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';
// import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationDataProvider {
  final _baseUrl = 'http://10.0.2.2:5000';
  final http.Client httpClient;
  AuthenticationDataProvider({@required this.httpClient})
      : assert(httpClient != null);

  Future<String> signInWithEmailAndPassword(User user) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'password': user.password, 'email': user.email}),
    );
    // final jwt = jsonDecode(response.body);
    // print(jwt);
    // final token = jwt['token'];
    // print(token);
    // Map<String, dynamic> payload = Jwt.parseJwt(token);

    // print(payload);

    if (response.statusCode == 201) {
      //return payload['sessionId'];
      return "";
    } else {
      throw Exception('Failed to retrieve user.');
    }
  }

  Future<User> getUser(int id) async {
    final response = await httpClient.get('$_baseUrl/users/$id');
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to retrieve user.');
    }
  }
}
