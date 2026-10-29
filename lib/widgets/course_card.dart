// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CourseProvider>(context);
    final isFav = provider.isFavorite(course);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(course.title),
        subtitle: Text('Kode: ${course.code} | SKS: ${course.credits}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol Ikon Favorit (Hati)
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                provider.toggleFavorite(course);
              },
            ),
            // Tombol Ikon Hapus (Tempat Sampah)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final scaffoldContext = context;
                
                final confirm = await showDialog<bool>(
                  context: scaffoldContext,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Konfirmasi Hapus'),
                    content: const Text('Apakah Anda yakin ingin menghapus course ini?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  if (!scaffoldContext.mounted) return;
                  await Provider.of<CourseProvider>(scaffoldContext, listen: false)
                      .deleteCourse(int.parse(course.id.toString()));

                  if (!scaffoldContext.mounted) return;

                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    const SnackBar(content: Text('Course berhasil dihapus')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}