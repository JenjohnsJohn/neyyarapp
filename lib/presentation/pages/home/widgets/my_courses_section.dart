import 'package:flutter/material.dart';

import 'package:neyyarapp/domain/entities/course.dart';
import 'package:neyyarapp/presentation/widgets/course_card.dart'; // Import your CourseCard widget

class MyCoursesSection extends StatelessWidget {
  final List<Course> courses;
  final Function(Course) onTap; // Callback for course card taps

  const MyCoursesSection({
    Key? key,
    required this.courses,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const SizedBox
          .shrink(); // Don't show anything if there are no enrolled courses
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // Constrain the height of the list
          height: 280, // Adjust this height based on design
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return SizedBox(
                width: 260,
                child: CourseCard(
                  course: course,
                  onTap: () => onTap(course),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16.0), // Add spacing below the list
      ],
    );
  }
}
