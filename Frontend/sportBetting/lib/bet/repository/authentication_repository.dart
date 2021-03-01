import '../data_provider/authentication_data.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';

class AuthenticationRepository {
  final AuthenticationDataProvider dataProvider;
  AuthenticationRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<User> getCurrentUser() async {
    //return await dataProvider.getCurrentUser(id);
  }

  Future<User> getUser(String id, String token) async {
    return await dataProvider.getUser(id, token);
  }

  Future<void> signOut() async {
    //return await dataProvider.createComment(comment);
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword(User user) async {
    return await dataProvider.signIn(user);
  }
}
