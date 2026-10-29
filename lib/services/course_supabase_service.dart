// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
// Sesuaikan path import di bawah ini jika file course_data_source.dart berada di folder lain, 
// misalnya jika satu folder gunakan: import 'course_data_source.dart';
import 'course_data_source.dart'; 

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Course> createCourse(Course course) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCourse(int id) async {
    throw UnimplementedError();
  }
}