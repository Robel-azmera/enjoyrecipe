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

//USER NAME COMMENTED

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String fullname = "";

  @override
  Widget build(BuildContext context) {
    UserSuccessfullySignedIn userState =
        BlocProvider.of<UserBloc>(context).state;
    User user = userState.user;
    // username = user.userName;
    fullname = user.fullName;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "PROFILE",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.teal,
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
                    color: Colors.teal,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$fullname",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return "Email can't be left empty";

                        return null;
                      },
                      initialValue: username,
                      style:
                          kTextFormFieldStyle.copyWith(color: Colors.black54),
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Email',
                          focusColor: Colors.teal,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.teal,
                          )),
                      onChanged: (value) => username = value,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RoundedButton(
                      text: 'Update',
                      onPressed: () {
                        // user.userName = username;
                        BlocProvider.of<UserBloc>(context).add(
                          UserUpdate(user),
                        );
                      },
                      color: Colors.teal),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RoundedButton(
                      text: 'Sign Out',
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(
                          UserSignOut(),
                        );
                        Navigator.pushNamed(context, LOGIN);
                      },
                      color: Colors.teal),
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
                      color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
