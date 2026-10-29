// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/foundation.dart';
import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseProvider with ChangeNotifier {
  final CourseApiService apiService;

  CourseProvider(this.apiService);

  List<Course> _courses = [];
  bool _isLoading = false;
  bool _isSaving = false;
  String _errorMessage = '';
  final Set<String> _favorites = {};

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  
  // Getter 'error' untuk mencocokkan panggilan di UI
  String get error => _errorMessage;
  String get errorMessage => _errorMessage;

  // Method loadCourses (alias dari fetchCourses)
  Future<void> loadCourses() async {
    await fetchCourses();
  }

  Future<void> fetchCourses() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _courses = await apiService.getCourses();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method createCourse
  Future<void> createCourse(Course course) async {
    _isSaving = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final newCourse = await apiService.createCourse(course);
      _courses.add(newCourse);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> addCourse(Course course) async {
    await createCourse(course);
  }

  Future<void> updateCourse(String id, Course course) async {
    _isSaving = true;
    try {
      await apiService.updateCourse(id, course);
      final index = _courses.indexWhere((c) => c.id.toString() == id);
      if (index != -1) {
        _courses[index] = course;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  // Tahap 8: HTTP DELETE Resource
  Future<void> deleteCourse(int id) async {
    try {
      await apiService.deleteCourse(id);
      _courses.removeWhere((course) => int.parse(course.id.toString()) == id);
      _favorites.remove(id.toString());
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Manajemen Favorit
  bool isFavorite(Course course) {
    return _favorites.contains(course.id.toString());
  }

  void toggleFavorite(Course course) {
    final idStr = course.id.toString();
    if (_favorites.contains(idStr)) {
      _favorites.remove(idStr);
    } else {
      _favorites.add(idStr);
    }
    notifyListeners();
  }
}