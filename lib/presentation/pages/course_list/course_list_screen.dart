import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/blocs/course_list_bloc/course_list_bloc.dart';
import '../../../presentation/widgets/course_card.dart'; // Your custom course card widget

class CourseListScreen extends StatefulWidget {
  final Map<String, dynamic>?
      arguments; // Optional arguments for filtering, sorting, etc.

  const CourseListScreen({Key? key, this.arguments}) : super(key: key);

  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  @override
  void initState() {
    super.initState();
    // You can fetch the initial list of courses based on widget.arguments
    // context.read<CourseListBloc>().add(FetchCoursesEvent(filter: widget.arguments?['category']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
          if (state is CourseListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CourseListLoaded) {
            return ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                return CourseCard(
                    course: state.courses[
                        index]); // Assuming you have a custom CourseCard widget
              },
            );
          } else if (state is CourseListError) {
            return Center(child: Text(state.message));
          } else {
            return Container(); // Default case, should not happen
          }
        },
      ),
    );
  }
}
