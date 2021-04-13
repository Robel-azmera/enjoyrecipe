import 'package:enjoyrecipe/Recipe/data_provider/data_provider.dart';
import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:meta/meta.dart';

class RecipeRepository {
  final RecipeDataProvider dataProvider;

  RecipeRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Recipe> createRecipe(Recipe recipe) async {
    return await dataProvider.createRecipe(recipe);
  }

  Future<List<Recipe>> getRecipies() async {
    return await dataProvider.getRecipies();
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await dataProvider.updateRecipe(recipe);
  }

  Future<void> updateRatingRecipe(Recipe recipe) async {
    await dataProvider.updateRatingRecipe(recipe);
  }

  Future<void> deleteRecipe(int id) async {
    await dataProvider.deleteRecipe(id);
  }
}
