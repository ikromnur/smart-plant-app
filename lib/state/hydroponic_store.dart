import 'package:flutter/foundation.dart';
import '../models/hydroponic_plant.dart';

class HydroponicStore extends ChangeNotifier {
  final List<HydroponicPlant> _plants = [];
  List<HydroponicPlant> get plants => List.unmodifiable(_plants);

  HydroponicStore() {
    _seed();
  }

  void add(HydroponicPlant p) {
    _plants.add(p);
    notifyListeners();
  }

  void update(String id, HydroponicPlant updated) {
    final i = _plants.indexWhere((e) => e.id == id);
    if (i != -1) {
      _plants[i] = updated;
      notifyListeners();
    }
  }

  void remove(String id) {
    _plants.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  HydroponicPlant? byId(String id) {
    try {
      return _plants.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  void _seed() {
    _plants.addAll([
      HydroponicPlant(
        id: 'p1',
        name: 'Lidah Mertua',
        room: 'Ruang Tamu',
        species: 'Sansevieria',
        days: 26,
        imageUrl: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
        leafCount: 10,
        lumens: 370,
        waterPercent: 88,
        temperatureC: 37,
        ph: 7,
        heightHistory: [
          HeightPoint(date: DateTime(2025, 4, 1), cm: 14),
          HeightPoint(date: DateTime(2025, 6, 1), cm: 15),
          HeightPoint(date: DateTime(2025, 7, 15), cm: 16),
        ],
      ),
      HydroponicPlant(
        id: 'p2',
        name: 'Sirih Gading',
        room: 'Ruang Tamu',
        species: 'Epipremnum aureum',
        days: 18,
        imageUrl: 'https://images.unsplash.com/photo-1524594154907-8d1d2660b5e3',
        leafCount: 25,
        lumens: 320,
        waterPercent: 20,
        temperatureC: 30,
        ph: 6.2,
        heightHistory: [
          HeightPoint(date: DateTime(2025, 4, 1), cm: 12),
          HeightPoint(date: DateTime(2025, 6, 1), cm: 14),
          HeightPoint(date: DateTime(2025, 7, 15), cm: 15),
        ],
      ),
    ]);
  }
}