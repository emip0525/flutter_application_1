// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter_application_1/models/course.dart';
import 'package:flutter_application_1/services/course_service.dart';

class CourseRepository {
  final CourseService service;

  CourseRepository(this.service);

  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }
}
