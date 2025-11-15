
class HeightPoint {
  final DateTime date;
  final double cm;
  const HeightPoint({required this.date, required this.cm});
}

class HydroponicPlant {
  final String id;
  String name;
  String room;
  String species;
  int days;
  String imageUrl;
  int leafCount;
  double lumens;
  double waterPercent;
  double temperatureC;
  double ph;
  List<HeightPoint> heightHistory;

  HydroponicPlant({
    required this.id,
    required this.name,
    required this.room,
    required this.species,
    required this.days,
    required this.imageUrl,
    required this.leafCount,
    required this.lumens,
    required this.waterPercent,
    required this.temperatureC,
    required this.ph,
    required this.heightHistory,
  });

  bool get needsAttention => waterPercent < 25 || ph < 5.5 || ph > 7.5;
}