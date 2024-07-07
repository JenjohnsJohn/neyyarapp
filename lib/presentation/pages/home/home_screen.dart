import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neyyarapp/app/injection_container.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../widgets/course_card.dart'; // Import your course card widget
import './widgets/category_carousel.dart';
import './widgets/course_list.dart';
import './widgets/featured_course_banner.dart';
import './widgets/my_courses_section.dart';
import '../course_details/course_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(48.0),
        //   child: CategoryCarousel(),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Handle search action (e.g., navigate to search screen)
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            print(state.featuredCourses);
            print(state.categories);
            print(state.myCourses);
            return SingleChildScrollView(
              child: Column(
                children: [
                  FeaturedCourseBanner(
                    course: state.featuredCourses.isNotEmpty
                        ? state.featuredCourses[0]
                        : null,
                    onTap: (course) {
                      // Navigator.pushNamed(
                      //   context,
                      //   '/courseDetails',
                      //   arguments: {'courseId': course.id},
                      // );
                    },
                  ),
                  CategoryCarousel(),
                  MyCoursesSection(
                    courses: state.myCourses,
                    onTap: (course) {
                      Navigator.pushNamed(
                        context,
                        '/courseDetails',
                        arguments: {'courseId': course.id},
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'All Courses',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CourseList(
                    courses: state.featuredCourses,
                    onTap: (course) {
                      Navigator.pushNamed(
                        context,
                        '/courseDetails',
                        arguments: {'courseId': course.id},
                      );
                    },
                  ),
                  // Add other sections/widgets here (e.g., premium courses, etc.)
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox
                .shrink(); // Empty container if in initial state
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: Handle navigation based on the tapped index
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_rounded),
            label: 'Live Class',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          // ... other bottom navigation items
        ],
      ),
    );
  }
}
