// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository) {
    loadCourses();
  }

  List<Course> courses = [];
  bool isLoading = false;
  bool isSaving = false;
  String? error;
  final Set<String> savedFavorites = {};

  Future<void> loadCourses() async {
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

  Future<bool> createCourse(Course newCourse) async {
    isSaving = true;
    notifyListeners();

    try {
      await repository.createCourse(newCourse);
      await loadCourses();
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Tambahkan fungsi ini untuk Tahap 7
  Future<bool> updateCourse(String id, Course updatedCourse) async {
    isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, updatedCourse);
      await loadCourses(); // Refresh list setelah berhasil update
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
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