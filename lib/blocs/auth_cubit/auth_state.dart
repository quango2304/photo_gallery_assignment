part of 'auth_cubit.dart';

abstract class AuthState {
  final GoogleSignInAccount? currentUser;

  const AuthState(this.currentUser);
}

class AuthInitial extends AuthState {
  const AuthInitial(super.currentUser);
}

class AuthChanged extends AuthState {
  const AuthChanged(super.currentUser);
}
