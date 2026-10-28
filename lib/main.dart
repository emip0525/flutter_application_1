import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/course_api_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  // Base URL sesuai dengan API endpoint dari dosen (tanpa /courses di belakang)
  const String apiBaseUrl = 'https://course-api-pearl.vercel.app';

  final courseService = CourseApiService(apiBaseUrl);
  final courseRepository = CourseRepository(courseService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository)..fetchCoursesData(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Data Manager - Miftah Fadilatus Sakhila',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal.shade700,
          secondary: Colors.amber.shade800,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade700,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}