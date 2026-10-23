// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/course.dart';

class CourseService {
  Future<List<Course>> loadCourses() async {
    final String jsonString = await rootBundle.loadString('assets/data/student_data.json');
    final Map<String, dynamic> data = jsonDecode(jsonString) as Map<String, dynamic>;
    final List<dynamic> courseList = data['courses'] as List<dynamic>? ?? [];

    return courseList
        .map((item) => Course.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
