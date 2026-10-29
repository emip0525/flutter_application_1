// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import '../models/course.dart';

class CourseState {
  final List<Course> courses;
  final bool isLoading;
  final bool isSaving;
  final String error;

  CourseState({
    this.courses = const [],
    this.isLoading = false,
    this.isSaving = false,
    this.error = '',
  });

  CourseState copyWith({
    List<Course>? courses,
    bool? isLoading,
    bool? isSaving,
    String? error,
  }) {
    return CourseState(
      courses: courses ?? this.courses,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }
}