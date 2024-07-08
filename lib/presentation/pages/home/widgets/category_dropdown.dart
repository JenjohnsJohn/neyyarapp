import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neyyarapp/presentation/blocs/home_bloc/home_bloc.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return DropdownMenu<String>(
            inputDecorationTheme:
                InputDecorationTheme(border: InputBorder.none),
            initialSelection: state.categories.first.name,
            requestFocusOnTap: false,
            trailingIcon: Icon(Icons.expand_more),
            label: const Text('Selected'),
            onSelected: (String? value) {},
            dropdownMenuEntries: state.categories.map((value) {
              String cateName = value.name;
              return DropdownMenuEntry<String>(
                value: cateName,
                label: value.name,
              );
            }).toList(),
          );
        } else if (state is HomeError) {
          return SizedBox(
            height: 10,
            child: Text('Error loading categories'),
          ); // Handle error
        } else {
          return Container(); // Handle loading or initial state
        }
      },
    );
  }
}
