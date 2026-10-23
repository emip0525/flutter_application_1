// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/course_provider.dart';
import 'package:flutter_application_1/widgets/course_card.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('2415051011 • Miftah Fadilatus Sakhila', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Katalog Kursus (${provider.courses.length})',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context.read<CourseProvider>().fetchCoursesData(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 48),
                          const SizedBox(height: 8),
                          Text('Gagal memuat data: ${provider.error}'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => context.read<CourseProvider>().fetchCoursesData(),
                            child: const Text('Coba Lagi'),
                          )
                        ],
                      ),
                    );
                  }

                  if (provider.courses.isEmpty) {
                    return const Center(child: Text('Data kursus kosong.'));
                  }

                  return ListView.builder(
                    itemCount: provider.courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: provider.courses[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}