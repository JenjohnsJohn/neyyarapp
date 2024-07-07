import 'package:neyyarapp/domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.instructor,
    required super.imageUrl,
    required super.rating,
    required super.numReviews,
    required super.price,
    required super.isFeatured,
    required super.isEnrolled,
    required super.category,
    // Add other properties from your JSON response if needed (e.g., duration, syllabus, lectures)
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      imageUrl: json['imageUrl'], // Or the appropriate key from your API
      rating: (json['rating'] as num)
          .toDouble(), // Assuming rating is a number in the JSON
      numReviews: json['numReviews'],
      price: (json['price'] as num)
          .toDouble(), // Assuming price is a number in the JSON
      isFeatured: json['isFeatured'],
      isEnrolled:
          json['isEnrolled'], // This might depend on your API's structure
      category: json['category'], // Or the appropriate key from your API
      // ... map other properties as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'imageUrl': imageUrl,
      'rating': rating,
      'numReviews': numReviews,
      'price': price,
      'isFeatured': isFeatured,
      'isEnrolled': isEnrolled,
      'category': category,
      // ... map other properties as needed
    };
  }
}
