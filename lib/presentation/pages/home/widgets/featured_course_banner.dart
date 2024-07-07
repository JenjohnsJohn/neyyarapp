import 'package:flutter/material.dart';
import 'package:neyyarapp/domain/entities/course.dart';

class FeaturedCourseBanner extends StatelessWidget {
  final Course? course;
  final Function(Course)? onTap;

  const FeaturedCourseBanner({Key? key, this.course, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return const SizedBox
          .shrink(); // Don't show anything if there's no featured course
    }

    return GestureDetector(
      onTap: () => onTap?.call(course!), // Navigate to course details if tapped
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(course!.imageUrl), // Display course image
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          course!.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
