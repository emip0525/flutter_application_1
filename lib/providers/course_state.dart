// Student ID: 2415051011 - Miftah Fadilatus Sakhila
import 'package:flutter/foundation.dart';

class CourseState extends ChangeNotifier {
  // Collection untuk menyimpan ID kursus yang difavoritkan
  final Set<String> favorites = {};

  // Fungsi untuk menambah atau menghapus kursus dari daftar favorit
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    // Memberitahu semua widget yang mendengar (listener) bahwa data telah berubah
    notifyListeners();
  }
}