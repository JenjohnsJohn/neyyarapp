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
      child: CustomScrollView(
        shrinkWrap: true,
        primary: false,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: .7,
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
