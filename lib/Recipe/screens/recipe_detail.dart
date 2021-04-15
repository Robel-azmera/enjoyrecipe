import 'dart:convert';
import 'dart:ffi';

import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_arg.dart';
import 'package:enjoyrecipe/api_config_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class RecipeDetail extends StatefulWidget {
  static const routeName = '/recipiesdetail';
  final Recipe recipe;

  RecipeDetail({@required this.recipe});

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  // double rating = 4.5;

  bool isnull = false;
  double rating;

  @override
  Widget build(BuildContext context) {
    rating = widget.recipe.rating.toDouble();
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('${widget.recipe.recipeName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateRecipe.routeName,
              arguments: RecipeArgument(recipe: widget.recipe, edit: true),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<RecipeBloc>().add(RecipeDelete(widget.recipe));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RecipeList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: ListView(
          children: [
            Expanded(
              child: Image.network("${Uri.parse(widget.recipe.image)}"),
            ),
            ListTile(
              title: Text(
                'Name: ${widget.recipe.recipeName}',
                style: TextStyle(color: Colors.white70, fontSize: 16.0),
              ),
              subtitle: Text('Instructions: ${widget.recipe.instructions}',
                  style: TextStyle(color: Colors.white70, fontSize: 16.0)),
            ),
            Column(
              children: [
                Text(
                  'Causions: ${widget.recipe.causions}',
                  style: TextStyle(color: Colors.white70, fontSize: 17.0),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 35),
                child: Row(
                  children: [
                    RatingBar.builder(
                      // initialRating: rating,
                      initialRating: rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rate) {
                        setState(() {
                          rating = rate;
                        });
                        print(rating);
                      },
                    ),
                    Text(
                      "$rating",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton(
                      onPressed: isnull
                          ? () {}
                          : () {
                              _updateRating();
                              setState(() {
                                isnull = !isnull;
                              });
                            },
                      child: isnull ? Text("Thanks") : Text("Rate"),
                      textColor: Colors.white70,
                      color: isnull ? Colors.grey[700] : Colors.teal[700],
                    )
                  ],
                )),
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
              this.widget.recipe.instructions,
              style: TextStyle(color: Colors.white60, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }

  _updateRating() async {
    final http.Response response = await http.put(
      '$baseURL/api/rest/recipe/rate',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-hasura-admin-secret':
            'gaiZAFZVjJ6tYXbl9ueMkhr3s7vpCO1yl5snWkfE9gKpWY8BlNahekMKNAxoCrZQ'
      },
      body: jsonEncode(<String, dynamic>{
        'id': widget.recipe.id,
        'rating': rating
        // 'name': widget.recipe.recipeName,
        // 'calories': widget.recipe.calories,
        // 'causions': widget.recipe.causions,
        // 'image': widget.recipe.image,
        // 'instructions': widget.recipe.instructions,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update Recipe . . . !');
    }
  }
}
