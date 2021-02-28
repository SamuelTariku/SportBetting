import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserDataProvider{
  final _baseUrl = 'http://10.0.2.2:5000';
  final http.Client httpClient;
  UserDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<User> createUser(User user) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, '/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'password': user.password,
        'email': user.email,

      }),
    );
    print("ppppppppppppppppppppppppppppppppppppppppppppppp");
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      // return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create comment.');
    }
  }


  Future<void> deleteUser(int id) async {
    final response = await httpClient.delete(
      '$_baseUrl/comments/delete/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete comment.');
    }
  }




  Future<void> updateUser(User user) async {
    final response = await httpClient.put(
      '$_baseUrl/comments/update/${user.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': user.id,
        'password': user.password,
        'email': user.email,
      }),
    );
    print('status code.${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update comment.');
    }
  }


}

