import 'dart:math';

import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_arg.dart';
import 'package:enjoyrecipe/routes.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/model/models.dart';
import 'package:enjoyrecipe/user/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeCategory extends StatefulWidget {
  static const routeName = '/recipies';

  @override
  _RecipeCategoryState createState() => _RecipeCategoryState();
}

class _RecipeCategoryState extends State<RecipeCategory> {
  String email = "";
  String fullname = "";
  String initialname = "";

  @override
  Widget build(BuildContext context) {
    UserSuccessfullySignedIn userState =
        BlocProvider.of<UserBloc>(context).state;
    User user = userState.user;
    fullname = user.fullName;
    email = user.email;
    initialname = fullname[0];

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      drawer: Drawer(
        child: SafeArea(
            child: ListView(
          children: [
            Container(
              height: 150,
              color: Color.fromRGBO(58, 66, 86, 0.9),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    "$initialname".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ), //assets/images/rob.JPG
                ),
                title: Text(
                  "$fullname",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                subtitle: Text(
                  "$email",
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            new Container(
              height: 800,
              color: Color.fromRGBO(58, 66, 86, 0.9),
              child: new Column(
                children: [
                  ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Account Info',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      }),
                  ListTile(
                      leading: Icon(
                        Icons.exit_to_app_sharp,
                        color: Colors.white,
                      ),
                      title: Text(
                        'SignOut',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<UserBloc>(context).add(
                          UserSignOut(),
                        );
                        Navigator.pushNamed(context, LOGIN);
                      }),
                ],
              ),
            )
          ],
        )),
      ),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enjoy',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.teal[300]),
            ),
            Text(
              'Recipe',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddUpdateRecipe.routeName,
                  arguments: RecipeArgument(edit: false));
            },
          )
        ],
      ),
      // bottomNavigationBar: makeTheBottom(context),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (_, state) {
          if (state is RecipeOperationFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Add Recipies',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddUpdateRecipe.routeName,
                          arguments: RecipeArgument(edit: false));
                    },
                  )
                ],
              ),
            );
          }

          if (state is RecipiesLoadSuccess) {
            final recipe = state.recipies;
            return ListView.builder(
              // padding: EdgeInsets.only(bottom: 10),
              itemCount: recipe.length,
              itemBuilder: (_, idx) => Card(
                color: Color.fromRGBO(58, 66, 86, 1.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Image.network(
                                  "${Uri.parse(recipe[idx].image)}",
                                  fit: BoxFit.fill,
                                  height: 250,
                                  width: 350,
                                ),
                              ),
                              Text(
                                "${recipe[idx].recipeName}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              RatingBar.builder(
                                itemSize: 15,
                                initialRating: recipe[idx].rating.toDouble(),
                                maxRating: 5,
                                minRating: 0,
                                unratedColor: Colors.white,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 3.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                // onRatingUpdate: (rate) {
                                //   setState(() {
                                //     // rating = rate;
                                //   });
                                //   // print(rating);
                                // },
                              ),
                              Text(
                                "Calories: ${recipe[idx].calories}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                              ),
                              Text(
                                "By: $fullname",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                          onTap: () => {
                                print(recipe[idx].rating),
                                Navigator.of(context).pushNamed(
                                    RecipeDetail.routeName,
                                    arguments: recipe[idx]),
                              })
                      // ListTile(
                      //   contentPadding: EdgeInsets.only(bottom: 20),
                      //   leading: new Container(
                      //     width: 70.0,
                      //     height: 190.0,
                      //     decoration: new BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       image: new DecorationImage(
                      //         fit: BoxFit.fill,
                      //         image:
                      //             NetworkImage("${Uri.parse(recipe[idx].image)}"),
                      //       ),
                      //     ),
                      //   ),
                      //   title: Text(
                      //     '${recipe[idx].recipeName}',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w500,
                      //         color: Colors.white,
                      //         fontSize: 19),
                      //   ),
                      //   subtitle: Text(
                      //     'Calorie: ${recipe[idx].calories}',
                      //     style: TextStyle(color: Colors.white54, fontSize: 14),
                      //   ),
                      //   onTap: () => Navigator.of(context).pushNamed(
                      //       RecipeDetail.routeName,
                      //       arguments: recipe[idx]),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// class RecipeList extends StatelessWidget {
//   static const routeName = '/recipies';
//   @override
//   Widget build(BuildContext context) {
//     return
//   }}

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
  title: Text('Recipes'),
  actions: <Widget>[
    IconButton(
      icon: Icon(Icons.add),
      onPressed: () {},
    )
  ],
);
