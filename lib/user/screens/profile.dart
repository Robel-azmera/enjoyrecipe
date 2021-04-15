import 'dart:core';

import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/model/models.dart';
import 'package:enjoyrecipe/constants.dart';
import 'package:enjoyrecipe/routes.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/model/models.dart';
import 'package:enjoyrecipe/widgets/rounded_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = "";
  String fullname = "";
  String password = "";
  String newpass = "";
  String oldpass = "";
  bool visible = false;

  void toggleVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserSuccessfullySignedIn userState =
        BlocProvider.of<UserBloc>(context).state;
    User user = userState.user;
    // username = user.userName;
    fullname = user.fullName;
    email = user.email;
    password = user.password;

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        centerTitle: true,
        title: Text(
          "PROFILE",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white12,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$fullname",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "$email",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 20.0),
                  child: Form(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return "Can't be left empty";

                        return null;
                      },
                      initialValue: password,
                      style:
                          kTextFormFieldStyle.copyWith(color: Colors.white54),
                      obscureText: visible ? true : false,

                      decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Old password',
                          labelText: "Old Password",
                          focusColor: Colors.teal,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white70, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
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
                                  ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white70,
                          )),
                      // onChanged: (value) => email = value,
                      onChanged: (value) => oldpass = value,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return "Can't be left empty";
                        return null;
                      },
                      // initialValue: email,
                      style:
                          kTextFormFieldStyle.copyWith(color: Colors.white54),
                      obscureText: visible ? true : false,

                      decoration: kInputDecoration.copyWith(
                          labelText: "New password",
                          hintText: 'Enter New Password',
                          hintStyle: TextStyle(color: Colors.white54),
                          focusColor: Colors.teal,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white70, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
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
                                  ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white70,
                          )),
                      onChanged: (value) => newpass = value,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RoundedButton(
                      text: 'UPDATE',
                      onPressed: () {
                        user.password = newpass;
                        BlocProvider.of<UserBloc>(context).add(
                          UserUpdate(user),
                        );
                      },
                      color: Colors.teal[700]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RoundedButton(
                      text: 'LOG OUT',
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(
                          UserSignOut(),
                        );
                        Navigator.pushNamed(context, LOGIN);
                      },
                      color: Colors.teal[700]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RoundedButton(
                      text: 'Delete Account',
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(
                          UserDelete(user),
                        );
                        Navigator.pushNamed(context, LOGIN);
                      },
                      color: Colors.red[800]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
