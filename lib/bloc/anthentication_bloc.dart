import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthenticationState {}

class Authenticated extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class AuthenticationBloc extends Cubit<AuthenticationState> {
  AuthenticationBloc() : super(Unauthenticated());

  void logIn() => emit(Authenticated());
  void logOut() => emit(Unauthenticated());
}