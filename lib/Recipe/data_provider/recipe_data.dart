import 'dart:convert';

import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:enjoyrecipe/api_config_files.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RecipeDataProvider {
  final http.Client httpClient;

  RecipeDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Recipe> createRecipe(Recipe recipe) async {
    final response = await httpClient.post(
      '$baseURL/api/rest/add/recipe',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
      body: jsonEncode(<String, dynamic>{
        // 'id': recipe.id,
        "name": recipe.recipeName,
        "calories": recipe.calories,
        "causions": recipe.causions,
        "image": recipe.image,
        "instructions": recipe.instructions,
      }),
    );

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body)["recipe"]);
    } else {
      throw Exception('Failed to create Recipe . . . !');
    }
  }

  Future<List<Recipe>> getRecipies() async {
    final response = await httpClient.post(
      '$baseURL/api/rest/recipes',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
    );

    if (response.statusCode == 200) {
      final recipies = jsonDecode(response.body) as List;
      return recipies.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load Recipies . . . !');
    }
  }

  Future<void> deleteRecipe(int id) async {
    final http.Response response = await httpClient.post(
      '$baseURL/api/rest/delete/recipe',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Recipe . . . !');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    final http.Response response = await httpClient.put(
      '$baseURL/api/rest/update/recipe',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
      body: jsonEncode(<String, dynamic>{
        'id': recipe.id,
        'name': recipe.recipeName,
        'calories': recipe.calories,
        'causions': recipe.causions,
        'image': recipe.image,
        'instructions': recipe.instructions,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update Recipe . . . !');
    }
  }
}
