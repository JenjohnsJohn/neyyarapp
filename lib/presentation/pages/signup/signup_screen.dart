import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neyyarapp/app/injection_container.dart';

import 'package:neyyarapp/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import './widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          // Listen for state changes
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              // Navigate to home screen upon successful sign-up
              Navigator.pushReplacementNamed(context, '/');
            } else if (state is AuthenticationFailure) {
              // Show error message using a ScaffoldMessenger snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: const SingleChildScrollView(
            child: SignupForm(),
          ),
        ),
      ),
    );
  }
}
