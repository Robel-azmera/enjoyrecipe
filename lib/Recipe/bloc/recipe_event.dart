import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();
}

class CheckRecipe extends RecipeEvent {
  final List<Recipe> recipe;

  const CheckRecipe(this.recipe);

  @override
  List<Object> get props => [recipe];

  @override
  String toString() => 'Recipe Created {Recipe: $recipe}';
}

class RecipeLoad extends RecipeEvent {
  const RecipeLoad();

  @override
  List<Object> get props => [];
}

class RecipeCreate extends RecipeEvent {
  final Recipe recipe;

  const RecipeCreate(this.recipe);

  @override
  List<Object> get props => [recipe];

  @override
  String toString() => 'Recipe Created {Recipe: $recipe}';
}

class RecipeUpdate extends RecipeEvent {
  final Recipe recipe;

  const RecipeUpdate(this.recipe);

  @override
  List<Object> get props => [recipe];

  @override
  String toString() => 'Recipe Updated {Recipe: $recipe}';
}

class RecipeRatingUpdate extends RecipeEvent {
  final Recipe recipe;

  const RecipeRatingUpdate(this.recipe);

  @override
  List<Object> get props => [recipe];

  @override
  String toString() => 'Recipe Updated {Recipe: $recipe}';
}

class RecipeDelete extends RecipeEvent {
  final Recipe recipe;

  const RecipeDelete(this.recipe);

  @override
  List<Object> get props => [recipe];

  @override
  toString() => 'Recipe Deleted {Recipe: $recipe}';
}
