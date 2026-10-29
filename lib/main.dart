// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/course_provider.dart';
import 'services/course_api_service.dart';
import 'repositories/course_repository.dart';
import 'screens/main_navigation_screen.dart';

Future<void> main() async {
  // 1. Pastikan Flutter binding terinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Konfigurasi kredensial Supabase (Gunakan URL dan Anon/Public Key project Anda)
  const String supabaseUrl = 'https://YOUR_SUPABASE_PROJECT_URL.supabase.co';
  const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY_PUBLIC';

  // 3. Inisialisasi Supabase sebelum runApp()
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  // 4. Perakitan service -> repository -> provider
  final String apiBaseUrl = 'https://api.example.com';
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