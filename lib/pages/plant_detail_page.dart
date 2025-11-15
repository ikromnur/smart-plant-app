import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/hydroponic_plant.dart';
import '../widgets/metric_card.dart';
import '../widgets/height_chart.dart';
import 'edit_plant_page.dart';

class PlantDetailPage extends StatelessWidget {
  final String id;
  const PlantDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final store = AppState.of(context);
    final HydroponicPlant p = store.byId(id)!;
    return Scaffold(
      appBar: AppBar(title: Text(p.name), actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditPlantPage(existing: p)),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            store.remove(p.id);
            Navigator.pop(context);
          },
        ),
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 28, backgroundImage: NetworkImage(p.imageUrl)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.name, style: Theme.of(context).textTheme.titleLarge),
              Text('${p.room} • ${p.days} Hari'),
            ])),
          ]),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Image.network(p.imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 12, runSpacing: 12, children: [
            MetricCard(icon: Icons.wb_sunny_outlined, label: 'Cahaya', value: '${p.lumens.toStringAsFixed(0)} Lumens', color: Colors.amber),
            MetricCard(icon: Icons.invert_colors, label: 'Sisa Air', value: '${p.waterPercent.toStringAsFixed(0)}%', color: Colors.blue),
            MetricCard(icon: Icons.device_thermostat, label: 'Suhu', value: '${p.temperatureC.toStringAsFixed(0)} C', color: Colors.red),
            MetricCard(icon: Icons.science, label: 'pH', value: p.ph.toString(), color: Colors.green),
          ]),
          const SizedBox(height: 16),
          Text('Ketinggian (cm)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          HeightChart(points: p.heightHistory),
          const SizedBox(height: 16),
          ListTile(leading: const Icon(Icons.spa), title: const Text('Jumlah Daun'), trailing: Text('${p.leafCount} buah')),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final updated = HydroponicPlant(
            id: p.id,
            name: p.name,
            room: p.room,
            species: p.species,
            days: p.days,
            imageUrl: p.imageUrl,
            leafCount: p.leafCount,
            lumens: p.lumens,
            waterPercent: 100,
            temperatureC: p.temperatureC,
            ph: p.ph,
            heightHistory: p.heightHistory,
          );
          store.update(p.id, updated);
        },
        icon: const Icon(Icons.water_drop),
        label: const Text('Siram Sekarang'),
      ),
    );
  }
}