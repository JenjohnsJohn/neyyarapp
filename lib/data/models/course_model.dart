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
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      numReviews: json['numReviews'],
      price: (json['price'] as num).toDouble(),
      isFeatured: json['isFeatured'],
      isEnrolled: json['isEnrolled'],
      category: json['category'],
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
    };
  }
}
