// import 'package:enjoyrecipe/screens/home_screen.dart';
import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/repository/repository.dart';
// import 'package:enjoyrecipe/user/bloc/bloc.dart';
import 'package:enjoyrecipe/user/model/models.dart';
// import 'package:enjoyrecipe/user/repository/repository.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;

  UserBloc(this.userRepository)
      : assert(userRepository != null),
        super(UserLoading());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserSignInWithEmail) {
      try {
        User user =
            await this.userRepository.signInUser(event.email, event.password);
        yield UserSuccessfullySignedIn(user);
        print(' LOGIN   SUCESSSSSSSSSSSSSSSSSSSSSSSSSSSS ...!');
      } catch (_) {
        yield UserFailedToSignIn();
      }
    } else if (event is UserSignInFromCache) {
      try {
        User user = await this.userRepository.getUserById();
        yield UserSuccessfullySignedIn(user);
      } catch (_) {
        yield UserFailedToSignIn();
      }
    } else if (event is UserSignUp) {
      print("In bloc");
      try {
        User user = await this.userRepository.createUser(event.user);
        yield UserSuccessfullySignedIn(user);
      } catch (err) {
        print("---------------------------$err");
        yield UserGeneralFailure("Error Signing up");
      }
    } else if (event is UserUpdate) {
      try {
        await this.userRepository.updateUser(event.user);
        User user = await this.userRepository.getUserByEmail(event.user.email);
        yield UserSuccessfullySignedIn(user);
      } catch (_) {
        yield UserGeneralFailure("Error updating user");
      }
    } else if (event is UserDelete) {
      try {
        await this.userRepository.deleteUser(event.user.id);
        yield UserSuccessfullySignedOut();
      } catch (_) {
        yield UserGeneralFailure("Error deleting user");
      }
    } else if (event is UserSignOut) {
      yield UserSuccessfullySignedOut();
    }
  }
}
