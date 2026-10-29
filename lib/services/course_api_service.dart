// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class CourseApiService {
  final String baseUrl;

  CourseApiService(this.baseUrl);

  Future<List<Course>> getCourses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/courses'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Course.fromJson(json)).toList();
      }
    } catch (_) {}

    return [
      Course(code: 'IF101', title: 'Pemrograman Mobile', credits: 3, status: 'active'),
      Course(code: 'IF102', title: 'Pemrograman Web', credits: 3, status: 'planned'),
      Course(code: 'IF103', title: 'Struktur Data', credits: 4, status: 'done'),
    ];
  }

  Future<Course> createCourse(Course course) async {
    return course;
  }

  Future<void> updateCourse(String id, Course course) async {}

  // Tahap 8: HTTP DELETE Resource
  Future<void> deleteCourse(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/courses/$id'),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal menghapus course');
    }
  }
}