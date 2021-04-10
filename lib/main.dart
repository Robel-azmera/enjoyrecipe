import 'package:enjoyrecipe/Recipe/data_provider/data_provider.dart';
import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/app.dart';
import 'package:enjoyrecipe/user/data_provider/data_provider.dart';
import 'package:enjoyrecipe/user/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'bloc_observer.dart';

Future<void> main() async {
  // Bloc.observer = SimpleBlocObserver();
  // final ItemRepository itemRepository = ItemRepository(
  //   dataProvider: ItemDataProvider(
  //     httpClient: http.Client(),
  //   ),
  // );

  final UserRepository userRepository = UserRepository(
    UserProvider(http.Client()),
  );
  final RecipeRepository recipeRepository = RecipeRepository(
      dataProvider: RecipeDataProvider(httpClient: http.Client()));

  runApp(EnjoyRecipe(
    userRepository: userRepository,
    recipeRepository: recipeRepository,
  ));
}
