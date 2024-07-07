import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/app.dart';
import '../app/injection_container.dart' as di;
import 'presentation/blocs/authentication_bloc/authentication_bloc.dart'; // Dependency Injection setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize your dependency injection setup

  runApp(
    RepositoryProvider(
      create: (context) => (_) => di.sl,
      child: MultiBlocProvider(
        // Provide necessary BLoCs at the root of your app
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => di.sl<AuthenticationBloc>()),
          // ...other Bloc providers
        ],
        child: App(), // Your main app widget defined in app.dart
      ),
    ),
  );
}
