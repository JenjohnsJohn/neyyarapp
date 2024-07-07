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
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(course!.imageUrl), // Display course image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                      0.7), // Semi-transparent black background for text
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  course!.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Add more information overlays or buttons here as desired (e.g., instructor, category, "Enroll Now" button)
          ],
        ),
      ),
    );
  }
}
