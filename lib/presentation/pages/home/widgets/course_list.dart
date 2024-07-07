import 'package:flutter/material.dart';
import 'package:neyyarapp/presentation/widgets/course_card.dart';
import 'package:neyyarapp/domain/entities/course.dart';

class CourseList extends StatelessWidget {
  final List<Course> courses;
  final Function(Course) onTap;

  const CourseList({
    Key? key,
    required this.courses,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: CustomScrollView(
        shrinkWrap: true,
        primary: false,
        slivers: [
          SliverPadding(
            // To add padding around the list
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              // Or use SliverList for a vertical list view
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.75, // Adjust the aspect ratio as needed
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final course = courses[index];
                  return CourseCard(
                    course: course,
                    onTap: () => onTap(course),
                  );
                },
                childCount: courses.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
