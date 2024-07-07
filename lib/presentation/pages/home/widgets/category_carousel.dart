import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neyyarapp/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:neyyarapp/domain/entities/category.dart';

class CategoryCarousel extends StatefulWidget {
  @override
  _CategoryCarouselState createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  String? _selectedCategoryId; // Keep track of the selected category

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Container(
            height: 48.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return GestureDetector(
                  onTap: () {
                    // Update the selected category in the bloc
                    context
                        .read<HomeBloc>()
                        .add(CategorySelected(categoryId: category.id));
                    setState(() {
                      _selectedCategoryId = category.id;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: _selectedCategoryId == category.id
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Center(
                      child: Text(
                        category.name,
                        style: TextStyle(
                          color: _selectedCategoryId == category.id
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is HomeError) {
          return Center(
              child: Text('Error loading categories')); // Handle error
        } else {
          return Container(); // Handle loading or initial state
        }
      },
    );
  }
}
