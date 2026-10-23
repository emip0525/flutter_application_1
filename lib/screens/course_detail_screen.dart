// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/course.dart';
import 'package:flutter_application_1/providers/course_provider.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final isFav = provider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: const Text('2415051011 • Miftah Fadilatus Sakhila', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        course.title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFav ? Icons.bookmark : Icons.bookmark_border,
                        color: isFav ? Colors.amber.shade800 : Colors.grey,
                        size: 32,
                      ),
                      onPressed: () {
                        context.read<CourseProvider>().toggleFavorite(course.code);
                      },
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text('Kode Mata Kuliah: ${course.code}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Bobot SKS: ${course.credits} SKS', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Status: ${course.status}', style: const TextStyle(fontSize: 16, color: Colors.teal)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isFav ? Colors.amber.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isFav ? 'Tersimpan di Favorit Saya' : 'Belum Ditambahkan ke Favorit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isFav ? Colors.amber.shade900 : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}