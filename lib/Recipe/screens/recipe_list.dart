import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_arg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeList extends StatelessWidget {
  static const routeName = '/recipies';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      bottomNavigationBar: makeTheBottom(context),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (_, state) {
          if (state is RecipeOperationFailure) {
            return Center(
              child: Text(
                'No Description Added',
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          if (state is RecipiesLoadSuccess) {
            final recipe = state.recipies;
            // print(parties[0].description);///debug
            return ListView.builder(
              itemCount: recipe.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text(
                  '${recipe[idx].recipeName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${recipe[idx].instructions}'),
                onTap: () => Navigator.of(context)
                    .pushNamed(RecipeDetail.routeName, arguments: recipe[idx]),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget makeTheBottom(BuildContext context) {
    return Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Navigator.of(context).pushNamed(HomePageScreen.routeName);
              },
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () => Navigator.of(context).pushNamed(
                AddUpdateRecipe.routeName,
                arguments: RecipeArgument(edit: false),
              ),
            ),
            // IconButton(
            //   icon: Icon(Icons.account_box, color: Colors.white),
            //   onPressed: () {},
            // )
          ],
        ),
      ),
    );
  }

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text('Election Informations'),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );
}
