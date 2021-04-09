import 'package:enjoyrecipe/app.dart';
import 'package:enjoyrecipe/routes.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/widgets/login_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<UserBloc>(context).add(UserSignInFromCache());
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<UserBloc, UserState>(
          listener: (context, userState) async {
            if (userState is UserFailedToSignIn ||
                userState is UserGeneralFailure) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Incorrect user credential.")));
            } else if (userState is UserSuccessfullySignedIn) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt("USER_ID", userState.user.id);

              Navigator.pushNamed(context, HOME);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Image.asset(
                  //         'assets/images/recipe.png',
                  //         width: 300,
                  //         height: 300,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // flutFoodLogo,
                  Expanded(
                    child: LoginContainer(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
