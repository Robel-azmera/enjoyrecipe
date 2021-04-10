import 'package:enjoyrecipe/constants.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/screens/signup.dart';
import 'package:enjoyrecipe/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class LoginContainer extends StatefulWidget {
  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  bool visible = false;
  String email = '';
  String password = '';

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
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/recipe.png',
                      width: 300,
                      height: 300,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
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
                    if (value.isEmpty) return "email can't be left empty";

                    return null;
                  },
                  style: kTextFormFieldStyle.copyWith(color: Colors.black54),
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      // floatingLabelBehavior:
                      //         FloatingLabelBehavior.always,
                      // contentPadding: EdgeInsets.symmetric(
                      //   horizontal: 30,
                      //   vertical: 18,
                      // ),
                      focusColor: Colors.teal,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF757575), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 2.0),
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
                      )),
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "Password can't be left empty";

                    return null;
                  },
                  style: kTextFormFieldStyle.copyWith(color: Colors.black54),
                  obscureText: visible ? true : false,
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF757575), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 2.0),
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
                      ),
                      suffixIcon: IconButton(
                          onPressed: toggleVisibility,
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
                  Text('Don\'t have an account?'),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.teal),
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
