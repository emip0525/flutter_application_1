// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/course_provider.dart';
import 'services/course_api_service.dart';
import 'repositories/course_repository.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  // apiBaseUrl latihan (tanpa /courses)
  final String apiBaseUrl = 'https://api.example.com';
  
  // Perakitan Dependency Injection
  final repository = CourseRepository(CourseApiService(apiBaseUrl));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CourseProvider(repository)..loadCourses(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Programming - Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}