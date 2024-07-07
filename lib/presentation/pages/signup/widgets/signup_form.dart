import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neyyarapp/presentation/blocs/authentication_bloc/authentication_bloc.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});
  @override
  SignupFormState createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ... (email, password, and name input fields with validation)

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: state is AuthenticationLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(
                                  SignUpRequested(
                                    // Directly create an instance of SignUpRequested
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                  ),
                                );
                          }
                        },
                  child: state is AuthenticationLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSignUpButtonPressed() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignUpRequested(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
        ),
      );
    }
  }
}
