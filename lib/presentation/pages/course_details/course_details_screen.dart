import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/course_details_bloc/course_details_bloc.dart';
import '../../../domain/entities/course.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseId;

  const CourseDetailsScreen({Key? key, required this.courseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailsBloc(
        getCourseDetails: getIt(), // Get use case from DI container
        enrollInCourse: getIt(),
      )..add(GetCourseDetailsEvent(courseId: courseId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Course Details'),
        ),
        body: BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
          builder: (context, state) {
            if (state is CourseDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CourseDetailsLoaded) {
              return _buildCourseDetails(context, state.course);
            } else if (state is CourseDetailsError) {
              return Center(child: Text(state.message));
            } else {
              return Container(); // Default case, shouldn't happen
            }
          },
        ),
      ),
    );
  }

  Widget _buildCourseDetails(BuildContext context, Course course) {
    return SingleChildScrollView(
      // Make content scrollable
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            course.imageUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            course.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 8),
          Text(
            'By ${course.instructor}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 16),
          Text(
            course.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 16),
          // Add syllabus, enrollment button, reviews, etc. here
        ],
      ),
    );
  }
}
