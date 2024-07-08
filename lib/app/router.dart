import 'package:flutter/material.dart';

import '../presentation/pages/home/home_screen.dart';
import '../presentation/pages/login/login_screen.dart';
import '../presentation/pages/signup/signup_screen.dart';
import '../presentation/pages/course_details/course_details_screen.dart';
// ... (Add other screens as you create them)

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/courseDetails':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(courseId: args['courseId']),
        );
      // Add other routes as needed
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
