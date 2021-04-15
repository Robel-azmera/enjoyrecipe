import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_arg.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_category.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_detail.dart';
import 'package:enjoyrecipe/user/screens/login.dart';
import 'package:enjoyrecipe/user/screens/profile.dart';
import 'package:enjoyrecipe/user/screens/signup.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class OnGenerateRouter {
  static Route onGenerateRouter(RouteSettings settings) {
    // if (settings.name == HOME) {
    //   return MaterialPageRoute(builder: (context) => HomePage());
    // } else
    if (settings.name == LOGIN) {
      return MaterialPageRoute(builder: (context) => LoginPage());
    } else if (settings.name == SIGN_UP) {
      return MaterialPageRoute(builder: (context) => SignupPage());
    } else if (settings.name == PROFILE) {
      return MaterialPageRoute(builder: (context) => ProfilePage());
    } else if (settings.name == RECIPE_LIST) {
      return MaterialPageRoute(builder: (context) => RecipeList());
    } else if (settings.name == RECIPE_CATEGORY) {
      return MaterialPageRoute(builder: (context) => RecipeCategory());
    } else if (settings.name == RECIPE_DETAIL) {
      Recipe recipe = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => RecipeDetail(
                recipe: recipe,
              ));
    } else if (settings.name == RECIPE_ADD_UPDATE) {
      RecipeArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateRecipe(
                args: args,
              ));
    }

    return MaterialPageRoute(builder: (context) => RecipeList());
  }
}

// else if (settings.name == ITEM_DETAIL) {
//       final Item item = settings.arguments;
//       return MaterialPageRoute(
//           builder: (context) => ItemDetail(
//                 item: item,
//               ));
//     } else if (settings.name == ORDER_UPDATE) {
//       final Order order = settings.arguments;
//       return MaterialPageRoute(
//         builder: (context) => OrderUpdateScreen(order),
//       );
//     }
