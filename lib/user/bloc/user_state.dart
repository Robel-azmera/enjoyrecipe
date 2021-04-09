import 'package:enjoyrecipe/user/model/models.dart';

abstract class UserState {
  const UserState();
}

class UserLoading extends UserState {}

class UserSuccessfullySignedIn extends UserState {
  User user;
  UserSuccessfullySignedIn(this.user);
}

class UserSuccessfullySignedOut extends UserState {}

class UserFailedToSignIn extends UserState {}

class UserGeneralFailure extends UserState {
  String error;

  UserGeneralFailure(this.error);
}
