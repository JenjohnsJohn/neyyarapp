import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neyyarapp/app/router.dart';
import 'package:neyyarapp/app/theme.dart';

import '../app/injection_container.dart' as di; // Dependency Injection setup
import '../presentation/blocs/authentication_bloc/authentication_bloc.dart'; // Your Authentication Bloc

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) => di.sl<AuthenticationBloc>()),
        // ...other Bloc providers
      ],
      child: MaterialApp(
        title: 'E-Learning App',
        theme: appTheme, // Apply your app's theme
        onGenerateRoute: AppRouter.onGenerateRoute, // Use your app's router
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess) {
              return HomeScreen(); // Replace with your actual home screen widget
            } else if (state is AuthenticationFailure) {
              return LoginScreen(); // Replace with your login screen widget
            } else {
              return SplashScreen(); // You might have a splash screen while checking authentication status
            }
          },
        ),
      ),
    );
  }
}
