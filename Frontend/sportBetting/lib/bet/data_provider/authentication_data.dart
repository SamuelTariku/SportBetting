import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationDataProvider {
  final _baseUrl = 'http://192.168.1.9:5000';
  final http.Client httpClient;
  AuthenticationDataProvider({@required this.httpClient})
      : assert(httpClient != null);

  Future<Map<String, dynamic>> signIn(User user) async {
    final response = await httpClient.post(
      Uri.http('192.168.1.9:5000', '/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'password': user.password,
        'username': user.username
      }),
    );
    final jwt = jsonDecode(response.body);
    print(jwt);
    final token = jwt['token'];
    print(token);
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    print(payload);

    if (response.statusCode == 201) {
      payload['token'] = token;
      return payload;
    } else {
      throw Exception('Failed to retrieve user.');
    }
  }

  Future<User> getUser(String id, String token) async {
    print("In users");
    print(token);
    final response =
        await httpClient.get('$_baseUrl/user/$id', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'x-access-token': '$token'
    });
    if (response.statusCode == 200) {
      print("users response");
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to retrieve user.');
    }
  }
}
