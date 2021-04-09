import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/Recipe/models/models.dart';
import 'package:enjoyrecipe/Recipe/recipe.dart';
import 'package:enjoyrecipe/Recipe/screens/recipe_arg.dart';
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
        title: Text(
            '${widget.args.edit ? "Edit Information" : "Add Information"}'),
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
          child: Column(
            children: [
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.recipe.recipeName : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Recipe Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Recipe Name',
                      border: OutlineInputBorder(),
                      hintText: 'Something'),
                  onSaved: (value) {
                    setState(() {
                      this._recipe["name"] = value;
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.recipe.calories : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Calories';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Calories',
                      border: OutlineInputBorder(),
                      hintText: '1000kal'),
                  onSaved: (value) {
                    this._recipe["calories"] = value;
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.recipe.causions : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Causion';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Causions',
                      border: OutlineInputBorder(),
                      hintText: 'medical'),
                  onSaved: (value) {
                    this._recipe["causions"] = value;
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.recipe.instructions : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Instructions:';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Instruction Steps',
                      border: OutlineInputBorder(),
                      hintText: ''),
                  onSaved: (value) {
                    setState(() {
                      this._recipe["instructions"] = value;
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.recipe.instructions : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Image:';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Image',
                      border: OutlineInputBorder(),
                      hintText: ''),
                  onSaved: (value) {
                    setState(() {
                      this._recipe["image"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
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
    );
  }
}
