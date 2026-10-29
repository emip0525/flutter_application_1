// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CourseProvider>(context);
    final isFav = provider.isFavorite(course);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red),
            onPressed: () {
              provider.toggleFavorite(course);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${course.code}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Judul: ${course.title}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('SKS: ${course.credits}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Status: ${course.status}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}