// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CourseProvider>(context);
    // Menyaring course yang menjadi favorit
    final favoriteCourses =
        provider.courses.where((c) => provider.isFavorite(c)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Favorit'),
      ),
      body: favoriteCourses.isEmpty
          ? const Center(child: Text('Belum ada course favorit.'))
          : ListView.builder(
              itemCount: favoriteCourses.length,
              itemBuilder: (context, index) {
                return CourseCard(course: favoriteCourses[index]);
              },
            ),
    );
  }
}