// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/course_provider.dart';
import 'services/course_api_service.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String baseUrl = 'https://api.example.com';
    final apiService = CourseApiService(baseUrl);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CourseProvider(apiService),
        ),
      ],
      child: MaterialApp(
        title: 'Mobile Programming - Clean Architecture',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}