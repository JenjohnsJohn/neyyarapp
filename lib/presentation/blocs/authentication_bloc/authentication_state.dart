part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  const AuthenticationSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({this.message = 'Authentication Failed'});

  @override
  List<Object> get props => [message];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

// Add more states as needed (e.g., for loading, error details)
