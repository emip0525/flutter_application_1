// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/course_provider.dart';
import 'package:flutter_application_1/widgets/course_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final favoriteList = provider.courses
        .where((c) => provider.isFavorite(c.code))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('2415051011 • Miftah Fadilatus Sakhila', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kursus Favorit Saya (${favoriteList.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: favoriteList.isEmpty
                  ? const Center(child: Text('Belum ada kursus yang difavoritkan.'))
                  : ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) {
                        return CourseCard(course: favoriteList[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}