import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String imageUrl; // Or use an ImageProvider for more flexibility
  final double rating;
  final int numReviews;
  final double price;
  final bool isFeatured;
  final bool isEnrolled;
  final String category;
  // Add more properties as needed (e.g., duration, syllabus, lectures, etc.)

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    this.imageUrl = "https://loremflickr.com/640/480/technics",
    this.rating = 2.0,
    this.numReviews = 15,
    this.price = 0.0,
    this.isFeatured = false,
    this.isEnrolled = false,
    this.category = '',
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        instructor,
        imageUrl,
        rating,
        numReviews,
        price,
        isFeatured,
        isEnrolled,
        category,
      ];

// Add methods related to the course entity if needed (e.g., calculateProgress())
}
