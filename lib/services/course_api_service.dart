// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  final String baseUrl;

  CourseApiService(this.baseUrl);

  @override
  Future<List<Course>> getCourses() async {
    
    final response = await http.get(Uri.parse('$baseUrl/courses_salah'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      // Melempar exception agar ditangkap oleh Provider & memunculkan ErrorView
      throw Exception('Gagal memuat data: Server merespons ${response.statusCode}');
    }
  }

  @override
  Future<Course> createCourse(Course course) async {
    return course;
  }

  @override
  Future<void> updateCourse(int id, Course course) async {}

  @override
  Future<void> deleteCourse(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/courses/$id'),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal menghapus course');
    }
  }
}