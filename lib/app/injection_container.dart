import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../core/network/network_info.dart';

import '../data/datasources/course_remote_data_source.dart';
import '../data/datasources/course_local_data_source.dart';
import '../data/repositories/course_repository_impl.dart';
import '../domain/repositories/course_repository.dart';
import '../domain/usecases/get_course_details.dart';
import '../domain/usecases/get_featured_courses.dart';
import '../domain/usecases/get_my_courses.dart';
import '../domain/usecases/enroll_in_course.dart';

import '../data/datasources/category_remote_data_source.dart';
import '../data/datasources/category_local_data_source.dart';
import '../data/repositories/category_repository_impl.dart';
import '../domain/repositories/category_repository.dart';
import '../domain/usecases/get_categories.dart';

import '../data/datasources/authentication_remote_data_source.dart';
import '../data/repositories/authentication_repository_impl.dart';
import '../domain/repositories/authentication_repository.dart';
import '../domain/usecases/check_authentication_status.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/sign_up.dart';

import '../presentation/blocs/home_bloc/home_bloc.dart';
import '../presentation/blocs/authentication_bloc/authentication_bloc.dart';
import '../presentation/blocs/course_details_bloc/course_details_bloc.dart';
// ... (Add other imports for your repositories, use cases, and data sources)

final sl =
    GetIt.instance; // Create a GetIt instance (sl stands for Service Locator)

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(() => HomeBloc(
        categoryRepository: sl(),
        courseRepository: sl(),
        getMyCourses: sl(),
      ));
  sl.registerFactory(() => AuthenticationBloc(
        login: sl(),
        logout: sl(),
        checkAuthenticationStatus: sl(),
        signUp: sl(),
      ));
  sl.registerFactory(() => CourseDetailsBloc(
        getCourseDetails: sl(),
        enrollInCourse: sl(),
      ));
  // ... (Add other Bloc registrations as needed)

  // Use cases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetFeaturedCourses(sl()));
  sl.registerLazySingleton(() => GetMyCourses(sl()));
  sl.registerLazySingleton(() => GetCourseDetails(sl()));
  sl.registerLazySingleton(() => EnrollInCourse(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));
  // ... (Add other use case registrations as needed)

  // Repositories
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
            networkInfo: sl(),
            authenticationRemoteDataSource: sl(),
          ));
  // ... (Add other repository registrations as needed)

  // Data sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CourseLocalDataSource>(
      () => CourseLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(client: sl()));
  // ... (Add other data source registrations as needed)

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // ... (Add other core component registrations as needed)

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  // ... (Register other external dependencies as needed)
}
