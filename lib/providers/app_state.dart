import 'package:flutter/material.dart';
import '../models/item.dart';

class AppState extends ChangeNotifier {
  bool isDark = false;
  final Set<int> favorites = {};

  final List<Item> items = List.generate(
    8,
        (i) => Item(
      id: i,
      title: 'Service ${i + 1}',
      subtitle: 'Professional service ${i + 1}',
      price: 299 + i * 50,
    ),
  );

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }

  void toggleFavorite(int id) {
    if (favorites.contains(id)) favorites.remove(id);
    else favorites.add(id);
    notifyListeners();
  }

  bool isFavorite(int id) => favorites.contains(id);
}
