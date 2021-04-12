import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_arg.dart';
import 'package:enjoyrecipe/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateRecipe extends StatefulWidget {
  static const routeName = '/recipiesaddupdate';
  final RecipeArgument args;

  AddUpdateRecipe({this.args});
  @override
  _AddUpdateRecipeState createState() => _AddUpdateRecipeState();
}

class _AddUpdateRecipeState extends State<AddUpdateRecipe> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _recipe = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('${widget.args.edit ? "Edit Recipe" : "Add Recipe"}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                      initialValue:
                          widget.args.edit ? widget.args.recipe.recipeName : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Recipe Name';
                        }
                        return null;
                      },
                      style: kTextFormFieldStyle,
                      decoration: InputDecoration(
                        hintText: 'Recipe Name',
                        focusColor: Colors.white30,
                        labelText: 'Recipe Name',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white70),
                          gapPadding: 10,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                          gapPadding: 10,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                      ),
                      onSaved: (value) {
                        setState(() {
                          this._recipe["name"] = value;
                        });
                      }), //   ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                      initialValue:
                          widget.args.edit ? widget.args.recipe.calories : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Calorie';
                        }
                        return null;
                      },
                      style: kTextFormFieldStyle,
                      decoration: InputDecoration(
                        hintText: 'Calories',
                        focusColor: Colors.white30,
                        labelText: 'Calories',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white70),
                          gapPadding: 10,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                          gapPadding: 10,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                      ),
                      onSaved: (value) {
                        setState(() {
                          this._recipe["calories"] = value;
                        });
                      }), //   ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                      initialValue:
                          widget.args.edit ? widget.args.recipe.causions : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Possible Causions';
                        }
                        return null;
                      },
                      style: kTextFormFieldStyle,
                      decoration: InputDecoration(
                        hintText: 'Causions',
                        focusColor: Colors.white30,
                        labelText: 'Causions',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white70),
                          gapPadding: 10,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                          gapPadding: 10,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                      ),
                      onSaved: (value) {
                        setState(() {
                          this._recipe["causions"] = value;
                        });
                      }), //   ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                      initialValue: widget.args.edit
                          ? widget.args.recipe.instructions
                          : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter The Instructions';
                        }
                        return null;
                      },
                      style: kTextFormFieldStyle,
                      decoration: InputDecoration(
                        hintText: 'Instructions',
                        focusColor: Colors.white30,
                        labelText: 'Instructions',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white70),
                          gapPadding: 10,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                          gapPadding: 10,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                      ),
                      onSaved: (value) {
                        setState(() {
                          this._recipe["instructions"] = value;
                        });
                      }), //   ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                      initialValue:
                          widget.args.edit ? widget.args.recipe.image : '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Image';
                        }
                        return null;
                      },
                      style: kTextFormFieldStyle,
                      decoration: InputDecoration(
                        hintText: 'Image',
                        focusColor: Colors.white30,
                        labelText: 'Image',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white70),
                          gapPadding: 10,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                          gapPadding: 10,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.red),
                          gapPadding: 10,
                        ),
                      ),
                      onSaved: (value) {
                        setState(() {
                          this._recipe["image"] = value;
                        });
                      }), //   ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        final RecipeEvent event = widget.args.edit
                            ? RecipeUpdate(
                                Recipe(
                                  id: widget.args.recipe.id,
                                  recipeName: this._recipe["name"],
                                  calories: this._recipe["calories"],
                                  instructions: this._recipe["instructions"],
                                  causions: this._recipe["causions"],
                                  image: this._recipe["image"],
                                ),
                              )
                            : RecipeCreate(
                                Recipe(
                                  // id: widget.args.election.id,
                                  id: this._recipe["id"],
                                  recipeName: this._recipe["name"],
                                  calories: this._recipe["calories"],
                                  instructions: this._recipe["instructions"],
                                  causions: this._recipe["causions"],
                                  image: this._recipe["image"],
                                ),
                              );
                        BlocProvider.of<RecipeBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RecipeList.routeName, (route) => true);
                      }
                    },
                    label: Text('SAVE'),
                    icon: Icon(Icons.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
