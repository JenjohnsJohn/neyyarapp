import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/check_authentication_status.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';
// Your User entity (e.g., User)
// Your login, logout, and check authentication status use cases

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Login _login;
  final Logout _logout;
  final CheckAuthenticationStatus _checkAuthenticationStatus;
  // ... other use cases

  AuthenticationBloc({
    required Login login,
    required Logout logout,
    required CheckAuthenticationStatus checkAuthenticationStatus,
    // ... other use cases
  })  : _login = login,
        _logout = logout,
        _checkAuthenticationStatus = checkAuthenticationStatus,
        super(AuthenticationInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    // ... add more event handlers for signup, password reset, etc.
  }

  void _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    final failureOrUser = await _checkAuthenticationStatus();
    failureOrUser.fold(
      (failure) => emit(AuthenticationFailure()),
      (user) => emit(AuthenticationSuccess(user: user)),
    );
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationSuccess(user: event.user));
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    await _logout();
    emit(AuthenticationFailure());
  }
}
