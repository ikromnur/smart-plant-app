import 'package:flutter/material.dart';
import '../models/hydroponic_plant.dart';

class PlantListItem extends StatelessWidget {
  final HydroponicPlant plant;
  final VoidCallback onTap;
  const PlantListItem({super.key, required this.plant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(plant.imageUrl)),
      title: Text(plant.name),
      subtitle: Text(plant.room),
      trailing: plant.needsAttention
          ? const Icon(Icons.error_outline, color: Colors.red)
          : null,
      onTap: onTap,
    );
  }
}