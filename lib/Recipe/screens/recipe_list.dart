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

class RecipeList extends StatefulWidget {
  static const routeName = '/recipies';

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
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
                    "$initialname",
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
              padding: EdgeInsets.only(right: 7, bottom: 10),
              itemCount: recipe.length,
              itemBuilder: (_, idx) => Card(
                color: Color.fromRGBO(58, 66, 86, 1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.only(bottom: 20),
                      leading: new Container(
                        width: 70.0,
                        height: 190.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/Pizza-2.jpg"),
                          ),
                        ),
                      ),
                      title: Text(
                        '${recipe[idx].recipeName}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 19),
                      ),
                      subtitle: Text(
                        'Calorie: ${recipe[idx].calories}',
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                      onTap: () => Navigator.of(context).pushNamed(
                          RecipeDetail.routeName,
                          arguments: recipe[idx]),
                    ),
                    // ButtonBar(
                    //   children: <Widget>[
                    //     FlatButton(
                    //       child: const Text(
                    //         'Details',
                    //         style: TextStyle(color: Colors.teal),
                    //       ),
                    //       onPressed: () {/* ... */},
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              // itemBuilder: (_, idx) => ListTile(
              //   leading: new Container(
              //     width: 70.0,
              //     height: 190.0,
              //     decoration: new BoxDecoration(
              //       shape: BoxShape.circle,
              //       image: new DecorationImage(
              //         fit: BoxFit.fill,
              //         image: AssetImage("assets/images/Pizza-2.jpg"),
              //       ),
              //     ),
              //   ),
              //   title: Text(
              //     '${recipe[idx].recipeName}',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.teal[100],
              //         fontSize: 19),
              //   ),
              //   subtitle: Text(
              //     'Calorie: ${recipe[idx].calories}',
              //     style: TextStyle(color: Colors.white54, fontSize: 15),
              //   ),
              //   onTap: () => Navigator.of(context)
              //       .pushNamed(RecipeDetail.routeName, arguments: recipe[idx]),
              // ),
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
  // actions: <Widget>[
  //   IconButton(
  //     icon: Icon(Icons.list),
  //     onPressed: () {},
  //   )
  // ],
);
