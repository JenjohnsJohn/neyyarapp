import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/course.dart'; // Import your Course entity

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course, required Function() onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to course details screen
        // Navigator.pushNamed(context, CourseDetailsScreen.routeName, arguments: {'courseId': course.id});
      },
      child: Card(
        elevation: .2,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  course.imageUrl,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: Text(
                course.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                    ),
                maxLines: 2,

                // Use headline6 style for title
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: Row(
                children: [
                  Text(
                    '${course.rating} ',
                    style: TextStyle(fontSize: 12),
                  ),
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    initialRating: course.rating,
                    maxRating: 5,
                    size: 15,
                  ),
                  Text(
                    '(${course.numReviews})',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                course.instructor,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            // Optionally, you can add a price or other details here
          ],
        ),
      ),
    );
  }
}
