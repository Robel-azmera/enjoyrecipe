// File defines app wide settings and themes

import 'package:enjoyrecipe/on_generate_router.dart';
import 'package:enjoyrecipe/routes.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/repository/repository.dart';

import 'package:enjoyrecipe/user/screens/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EnjoyRecipe extends StatelessWidget {
  // final ItemRepository itemRepository;
  final UserRepository userRepository;

  EnjoyRecipe({@required this.userRepository}) : assert(userRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) {},
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => UserBloc(this.userRepository)),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.teal,
              fontFamily: 'Muli',
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: LOGIN,
            onGenerateRoute: OnGenerateRouter.onGenerateRouter,
          )),
    );
  }
}
