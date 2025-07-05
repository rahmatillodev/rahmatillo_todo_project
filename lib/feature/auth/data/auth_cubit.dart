import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isLoggedIn;
  final String? userEmail;

  const AuthState({required this.isLoggedIn, this.userEmail});

  factory AuthState.initial() => const AuthState(isLoggedIn: false);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  void login(String email) => emit(AuthState(isLoggedIn: true, userEmail: email));

  void logout() => emit(AuthState.initial());
}
