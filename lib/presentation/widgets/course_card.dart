import 'package:flutter/material.dart';
import '../../domain/entities/course.dart'; // Import your Course entity

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course, required Function() onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(course);
    return GestureDetector(
      onTap: () {
        // Navigate to course details screen
        // Navigator.pushNamed(context, CourseDetailsScreen.routeName, arguments: {'courseId': course.id});
      },
      child: Card(
        child: Column(
          // Stretch content to fill card width
          children: [
            Image.network(
              course.imageUrl, // Display the course image
              height: 100,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge, // Use headline6 style for title
                  ),
                  SizedBox(height: 4), // Add some spacing
                  Text(
                    course.instructor,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text('${course.rating} (${course.numReviews})'),
                    ],
                  ),
                ],
              ),
            ),
            // Optionally, you can add a price or other details here
          ],
        ),
      ),
    );
  }
}
