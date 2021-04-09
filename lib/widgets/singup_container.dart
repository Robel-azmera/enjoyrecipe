import 'dart:math';

import 'package:enjoyrecipe/constants.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/model/models.dart';
import 'package:enjoyrecipe/user/screens/login.dart';
import 'package:enjoyrecipe/user/screens/signup.dart';
import 'package:enjoyrecipe/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupContainer extends StatefulWidget {
  @override
  _SignupContainerState createState() => _SignupContainerState();
}

class _SignupContainerState extends State<SignupContainer> {
  String email = '';
  String password = '';
  String fullname = '';
  bool visible = false;

  final _formKey = GlobalKey<FormState>();

  void toggleVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 90, left: 20, right: 20, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ENJOY',
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 45,
                          ),
                        ),
                        Text(
                          'Recipe',
                          style: TextStyle(fontSize: 45),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Register',
                style: TextStyle(
                  color: Color(0xFF58585A),
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "Name can't be left empty";

                    return null;
                  },
                  style: kTextFormFieldStyle,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    focusColor: Colors.teal,
                    labelText: 'Full Name',
                    prefixIcon: Icon(
                      Icons.account_circle,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Color(0xFF757575)),
                      gapPadding: 10,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.red),
                      gapPadding: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.teal),
                      gapPadding: 10,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.red),
                      gapPadding: 10,
                    ),
                  ),
                  onChanged: (value) => fullname = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "Email can't be left empty";

                    return null;
                  },
                  style: kTextFormFieldStyle,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.mail,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Color(0xFF757575)),
                      gapPadding: 10,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.red),
                      gapPadding: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.teal),
                      gapPadding: 10,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.red),
                      gapPadding: 10,
                    ),
                  ),
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 25),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "Password can't be empty";
                    return null;
                  },
                  style: kTextFormFieldStyle,
                  obscureText: visible ? true : false,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      onPressed: toggleVisibility,
                      icon: visible
                          ? Icon(
                              Icons.visibility_off,
                            )
                          : Icon(
                              Icons.visibility,
                            ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Color(0xFF757575)),
                      gapPadding: 10,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.red),
                      gapPadding: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.teal),
                      gapPadding: 10,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.red),
                      gapPadding: 10,
                    ),
                  ),
                  onChanged: (value) => password = value,
                ),
              ),
              CheckboxListTile(
                value: true,
                activeColor: Colors.teal,
                onChanged: (value) {},
                title: Text(
                  'I Agree to the Terms and Condtions',
                  style: TextStyle(color: Colors.black45, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 0),
                child: Row(
                  children: [
                    Text('Already have an account?',
                        style: TextStyle(color: Colors.black45, fontSize: 15)),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.teal),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RoundedButton(
                  text: 'Sign Up',
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      int random = Random().nextInt(1000);
                      UserEvent event = UserSignUp(
                        User(
                          email: email,
                          password: password,
                          fullName: fullname,
                          // phone: "$random",
                        ),
                      );

                      BlocProvider.of<UserBloc>(context).add(event);
                    }
                  },
                  color: Colors.teal,
                  labelColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
