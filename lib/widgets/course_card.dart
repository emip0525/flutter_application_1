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
    // Simpan salinan navigator/scaffold context jika diperlukan, 
    // atau gunakan penjagaan strict mounted.
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(course.title),
        subtitle: Text('Kode: ${course.code} | SKS: ${course.credits}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final scaffoldContext = context;
            
            // 2. Tampilkan AlertDialog konfirmasi sebelum menghapus
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

            // 3. Jalankan DELETE setelah user menyetujui
            if (confirm == true) {
              if (!scaffoldContext.mounted) return;
              await Provider.of<CourseProvider>(scaffoldContext, listen: false)
                  .deleteCourse(int.parse(course.id.toString()));

              // 5. Periksa context.mounted sebelum menampilkan SnackBar
              if (!scaffoldContext.mounted) return;

              // 4. Refresh list dan tampilkan SnackBar
              ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                const SnackBar(content: Text('Course berhasil dihapus')),
              );
            }
          },
        ),
      ),
    );
  }
}