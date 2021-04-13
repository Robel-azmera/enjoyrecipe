import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/Recipe/repository/recipe_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository dataRepository;

  RecipeBloc({@required this.dataRepository})
      : assert(dataRepository != null),
        super(RecipeLoading());

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is RecipeLoad) {
      yield RecipeLoading();
      try {
        final recipies = await dataRepository.getRecipies();
        yield RecipiesLoadSuccess(recipies);
      } catch (_) {
        yield RecipeOperationFailure();
      }
    }

    if (event is RecipeCreate) {
      try {
        await dataRepository.createRecipe(event.recipe);
        final recipies = await dataRepository.getRecipies();
        yield RecipiesLoadSuccess(recipies);
      } catch (i) {
        print(i);
        yield RecipeOperationFailure();
      }
    }

    if (event is RecipeUpdate) {
      try {
        await dataRepository.updateRecipe(event.recipe);
        final recipe = await dataRepository.getRecipies();
        yield RecipiesLoadSuccess(recipe);
      } catch (_) {
        // print(i); debug
        yield RecipeOperationFailure();
      }
    }
    if (event is RecipeRatingUpdate) {
      try {
        await dataRepository.updateRatingRecipe(event.recipe);
        final recipe = await dataRepository.getRecipies();
        yield RecipiesLoadSuccess(recipe);
      } catch (_) {
        // print(i); debug
        yield RecipeOperationFailure();
      }
    }

    if (event is RecipeDelete) {
      try {
        await dataRepository.deleteRecipe(event.recipe.id);
        final recipies = await dataRepository.getRecipies();
        yield RecipiesLoadSuccess(recipies);
      } catch (_) {
        yield RecipeOperationFailure();
      }
    }
  }
}
