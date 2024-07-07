import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neyyarapp/core/error/failures.dart';

import '../../../app/injection_container.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/check_authentication_status.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';
import '../../../domain/usecases/sign_up.dart';
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
    // Private method to handle the sign-up logic
    Future<Either<Failure, User>> _signUp(
        String email, String password, String name) async {
      // Call the sign-up use case and handle the result
      final failureOrUser = await sl<SignUp>().call(email, password,
          name); // Assuming you have registered SignUp in your dependency injection container
      return failureOrUser.fold(
        (failure) => Left(failure),
        (user) => Right(user),
      );
    }

    // ... your event handlers ...

    on<SignUpRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final failureOrSuccess =
          await _signUp(event.email, event.password, event.name);
      emit(failureOrSuccess.fold(
        (failure) =>
            AuthenticationFailure(message: _mapFailureToMessage(failure)),
        (user) => AuthenticationSuccess(user: user),
      ));
    });
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

  // Private method to map failures to messages
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error';
      case CacheFailure:
        return 'Cache Error';
      case InvalidCredentialsFailure:
        return 'Invalid email or password';
      case EmailAlreadyInUseFailure:
        return 'Email already in use';
      default:
        return 'Unexpected Error';
    }
  }
}
