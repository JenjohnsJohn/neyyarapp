import 'package:flutter/material.dart';

import 'pages/course_list/course_list_screen.dart';
import 'pages/course_details/course_details_screen.dart';
// ... other relevant imports for your screens related to the Home feature

class HomeRouter {
  static const String courseList = '/courseList';
  static const String courseDetails = '/courseDetails';
  // Add more named routes as needed for the Home feature

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case courseList:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => CourseListScreen(arguments: args));
      case courseDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => CourseDetailsScreen(courseId: args['courseId']));
      // Add other routes for the home feature
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                  child: Text('Error: No route defined for ${settings.name}')),
            ));
  }
}
