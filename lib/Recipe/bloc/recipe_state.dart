import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:equatable/equatable.dart';

class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeLoading extends RecipeState {}

class RecipiesLoadSuccess extends RecipeState {
  final List<Recipe> recipies;

  RecipiesLoadSuccess([this.recipies = const []]);

  @override
  List<Object> get props => [recipies];
}

class RecipeOperationFailure extends RecipeState {}
