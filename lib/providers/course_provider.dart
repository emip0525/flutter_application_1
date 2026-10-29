// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/foundation.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider with ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> _courses = [];
  bool _isLoading = false;
  bool _isSaving = false;
  String _errorMessage = '';
  final Set<String> _favorites = {};

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String get error => _errorMessage;
  String get errorMessage => _errorMessage;

  Future<void> loadCourses() async {
    await fetchCourses();
  }

  Future<void> fetchCourses() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // =========================================================================
      // PETUNJUK UNTUK SCREENSHOT KASUS A:
      // Biarkan baris di bawah ini AKTIF untuk memaksa munculnya halaman ErrorView 
      // dan tombol Retry di emulator.
      // =========================================================================
      throw Exception('HTTP 404: Endpoint /courses tidak ditemukan');

      // (Kode asli di bawah ini akan dijalankan kembali setelah selesai screenshot)
      // _courses = await repository.getCourses();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCourse(Course course) async {
    _isSaving = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final newCourse = await repository.createCourse(course);
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
    notifyListeners();

    try {
      await repository.updateCourse(int.parse(id), course);
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

  Future<void> deleteCourse(int id) async {
    try {
      await repository.deleteCourse(id);
      _courses.removeWhere((course) => int.parse(course.id.toString()) == id);
      _favorites.remove(id.toString());
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

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