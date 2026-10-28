// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  final CourseApiService apiService;

  CourseRepository(this.apiService);

  Future<List<Course>> getCourses() async {
    return await apiService.getCourses();
  }

  Future<Course> createCourse(Course course) async {
    return await apiService.createCourse(course);
  }

  // Tambahkan fungsi ini untuk Tahap 7
  Future<void> updateCourse(String id, Course course) async {
    await apiService.updateCourse(id, course);
  }
}