import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elearning_app/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:elearning_app/app/injection_container.dart';
import 'package:neyyarapp/presentation/pages/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          // Listen for state changes
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              // Navigate to home screen upon successful login
              Navigator.pushReplacementNamed(context, '/');
            } else if (state is AuthenticationFailure) {
              // Show error message (e.g., using a snackbar or dialog)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: LoginForm(), // Display the login form
        ),
      ),
    );
  }
}
