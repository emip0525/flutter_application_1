// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/error_view.dart';
import 'course_form_screen.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Data Manager'),
      ),
      body: Column(
        children: [
          // Banner Identitas Mahasiswa (Wajib Tampil)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: Colors.teal.shade100,
            child: const Text(
              '2415051011 • Miftah Fadilatus Sakhila',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Consumer<CourseProvider>(
              builder: (context, provider, child) {
                // 1. Loading State
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 2. Error State
                if (provider.error != null) {
                  return ErrorView(
                    message: provider.error!,
                    onRetry: () {
                      provider.loadCourses();
                    },
                  );
                }

                // 3. Empty State
                if (provider.courses.isEmpty) {
                  return const Center(
                    child: Text(
                      'Data course belum tersedia',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                // 4. Success State (Tampilkan Data)
                return ListView.builder(
                  itemCount: provider.courses.length,
                  itemBuilder: (context, index) {
                    final course = provider.courses[index];
                    return ListTile(
                      leading: const Icon(Icons.book, color: Colors.teal),
                      title: Text(course.title),
                      subtitle: Text('Kode: ${course.code} | SKS: ${course.credits}'),
                      trailing: Text('Status: ${course.status}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Floating Action Button untuk navigasi ke form tambah course (Tahap 6)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CourseFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}