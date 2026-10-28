// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/course.dart';
import 'package:flutter_application_1/repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository) {
    // Memuat data otomatis saat provider dibuat
    fetchCoursesData();
  }

  List<Course> courses = [];
  bool isLoading = false;
  String? error;
  final Set<String> savedFavorites = {};

  Future<void> fetchCoursesData() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Alias method agar kompatibel dengan pemanggilan loadCourses() / tombol Retry di UI Tahap 5
  Future<void> loadCourses() async {
    await fetchCoursesData();
  }

  bool isFavorite(String courseCode) {
    return savedFavorites.contains(courseCode);
  }

  void toggleFavorite(String courseCode) {
    if (savedFavorites.contains(courseCode)) {
      savedFavorites.remove(courseCode);
    } else {
      savedFavorites.add(courseCode);
    }
    notifyListeners();
  }
}