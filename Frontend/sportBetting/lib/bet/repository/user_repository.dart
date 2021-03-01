import '../data_provider/user_data.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  UserRepository({@required this.dataProvider}) : assert(dataProvider != null);

  Future<User> createUser(User user) async {
    return await dataProvider.createUser(user);
  }

  Future<void> updateUser(User user) async {
    await dataProvider.updateUser(user);
  }

  Future<void> deleteUser(int id) async {
    // await dataProvider.deleteUser(id);
  }
}
