import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_arg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetail extends StatelessWidget {
  static const routeName = '/recipiesdetail';
  final Recipe recipe;

  RecipeDetail({@required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('Notice Board'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateRecipe.routeName,
              arguments: RecipeArgument(recipe: this.recipe, edit: true),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<RecipeBloc>().add(RecipeDelete(this.recipe));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RecipeList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Name: ${this.recipe.recipeName}',
                style: TextStyle(color: Colors.white70, fontSize: 16.0),
              ),
              subtitle: Text('Instructions: ${this.recipe.instructions}',
                  style: TextStyle(color: Colors.white70, fontSize: 16.0)),
            ),
            Column(
              children: [
                Text(
                  'Causions: ${this.recipe.causions}',
                  style: TextStyle(color: Colors.white70, fontSize: 17.0),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 35),
              child: Text(
                'Details',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              this.recipe.instructions,
              style: TextStyle(color: Colors.white60, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
