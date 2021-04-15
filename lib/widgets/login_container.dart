import 'dart:math';

import 'package:enjoyrecipe/Recipe/bloc/bloc.dart';
import 'package:enjoyrecipe/constants.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/screens/signup.dart';
import 'package:enjoyrecipe/widgets/progress_button.dart';
import 'package:enjoyrecipe/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class LoginContainer extends StatefulWidget {
  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  bool visible = false;
  String email = '';
  String password = '';

  int _state;

  final _formKey = GlobalKey<FormState>();

  void toggleVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // BlocBuilder<UserBloc, UserState>(
    //   builder: (_, state) => {

    //   },
    // );

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/food.png',
                      alignment: Alignment.center,
                      width: 350,
                      height: 350,
                    ),
                  )
                ],
              ),
              Text(
                'Login',
                style: kButtonTextStyle,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "Email can't be left empty";

                    return null;
                  },
                  style: kTextFormFieldStyle.copyWith(color: Colors.white70),
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(color: Colors.white70),
                      labelStyle: TextStyle(color: Colors.white70),
                      // floatingLabelBehavior:
                      //         FloatingLabelBehavior.always,
                      // contentPadding: EdgeInsets.symmetric(
                      //   horizontal: 30,
                      //   vertical: 18,
                      // ),
                      focusColor: Colors.white30,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white70, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Colors.red),
                        gapPadding: 10,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Colors.red),
                        gapPadding: 10,
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.white70,
                      )),
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password can't be left empty";
                    } else if (value.length < 6) {
                      return "Password Must be atleast 6";
                    }

                    return null;
                  },
                  style: kTextFormFieldStyle.copyWith(color: Colors.white70),
                  obscureText: visible ? true : false,
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: TextStyle(color: Colors.white70),
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white70, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Colors.red),
                        gapPadding: 10,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Colors.red),
                        gapPadding: 10,
                      ),
                      focusColor: Colors.teal,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white70,
                      ),
                      suffixIcon: IconButton(
                          onPressed: toggleVisibility,
                          color: Colors.white70,
                          icon: visible
                              ? Icon(
                                  Icons.visibility_off,
                                )
                              : Icon(
                                  Icons.visibility,
                                )),
                      labelText: 'Password'),
                  onChanged: (value) => password = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RoundedButton(
                    text: 'Login',
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        final event = UserSignInWithEmail(email, password);
                        BlocProvider.of<UserBloc>(context).add(event);
                        // _formKey.currentState.save();
                      } else {
                        print("Form Not Validated");
                      }
                    },
                    color: Colors.teal),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.teal[200]),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
