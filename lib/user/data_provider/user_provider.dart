import 'dart:convert';

import 'package:enjoyrecipe/api_config_files.dart';
import 'package:enjoyrecipe/user/model/models.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  final Client httpClient;

  UserProvider(this.httpClient) : assert(httpClient != null);

  Future<User> getUserByEmail(String email) async {
    // final queryParameters = {'email': email};
    // final uri = Uri.http('$baseURL', '/api/rest/user/byemail', queryParameters);

    final response = await httpClient.post(
      "$baseURL/api/rest/user/byemail",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error creating user");
  }

  Future<User> getUserById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id;

    if (prefs.getInt('USER_ID') == null) {
      throw Exception("Error fetching user");
    } else
      id = prefs.getInt('USER_ID');

    final response = await httpClient.post(
      "$baseURL/api/rest/user/byid",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
      body: jsonEncode(<String, dynamic>{
        // "username": user.userName,
        // "phone": user.phone,

        "id": id,
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error creating user");
  }

  Future<User> signInUser(String email, String password) async {
    print("$baseURL/api/rest/user/byemail");

    final response = await this.httpClient.post(
          "$baseURL/api/rest/user/byemail",
          headers: <String, String>{
            'x-hasura-admin-secret':
                'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
          },
          body: jsonEncode(<String, dynamic>{
            "email": email,
          }),
        );

    print("In sign in method");
    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body)["Users"][0]);
      print('${user.fullName}');
      if (user.password == password) return user;
      throw Exception("Wrong Credential");
    }
    throw Exception("Error signing in user");
  }

  Future<User> createUser(User user) async {
    final response = await httpClient.post(
      "$baseURL/api/rest/user/register",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
      body: jsonEncode(<String, dynamic>{
        // "username": user.userName,
        // "phone": user.phone,

        "email": user.email,
        "fullname": user.fullName,
        "password": user.password
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error creating user");
  }

  Future<void> updateUser(User user) async {
    final response = await this.httpClient.put(
          "$baseURL/api/rest/user/id",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-hasura-admin-secret':
                'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ',
          },
          body: jsonEncode(<String, dynamic>{
            // "username": user.userName,
            // "phone": user.phone,
            "id": user.id,
            "email": user.email,
            "fullname": user.fullName,
            "password": user.password
          }),
        );

    if (response.statusCode != 200) throw Exception("Error updating user data");
  }

  Future<void> deleteUser(int id) async {
    final response =
        await this.httpClient.delete("$baseURL/api/rest/user/delete/$id");

    if (response.statusCode != 204) {
      throw Exception("Error deleting user");
    }
  }
}
