import 'dart:convert';

import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RecipeDataProvider {
  final baseUrl = '192.168.126.57:9090';
  final http.Client httpClient;

  RecipeDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Recipe> createRecipe(Recipe recipe) async {
    final response = await httpClient.post(
      Uri.http('$baseUrl', '/recipies'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Recipe . . . !');
    }
  }

  Future<List<Recipe>> getRecipies() async {
    final response = await httpClient.get('$baseUrl/recipies');

    if (response.statusCode == 200) {
      final recipies = jsonDecode(response.body) as List;
      return recipies.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load Recipies . . . !');
    }
  }

  Future<void> deleteRecipe(int id) async {
    final http.Response response = await httpClient.delete(
      '$baseUrl/recipies/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete Recipe . . . !');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    final http.Response response = await httpClient.put(
      '$baseUrl/recipies/${recipe.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
