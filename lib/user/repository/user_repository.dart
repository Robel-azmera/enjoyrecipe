import 'dart:async';

import 'package:enjoyrecipe/user/data_provider/user_provider.dart';
import 'package:enjoyrecipe/user/model/models.dart';

class UserRepository {
  final UserProvider userProvider;

  UserRepository(this.userProvider) : assert(userProvider != null);

  Future<User> getUserByEmail(String email) async {
    return await this.userProvider.getUserByEmail(email);
  }

  Future<User> getUserById() async {
    return await this.userProvider.getUserById();
  }

  Future<User> signInUser(String email, String password) async {
    return await this.userProvider.signInUser(email, password);
  }

  Future<User> createUser(User user) async {
    return await this.userProvider.createUser(user);
  }

  Future<void> updateUser(User user) async {
    return await this.userProvider.updateUser(user);
  }

  Future<void> deleteUser(int id) async {
    return await this.userProvider.deleteUser(id);
  }
}
