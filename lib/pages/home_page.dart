import 'package:flutter/material.dart';
import '../app_state.dart';
import '../widgets/plant_list_item.dart';
import 'plant_detail_page.dart';
import 'edit_plant_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppState.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Plant')),
      body: ListView.builder(
        itemCount: store.plants.length,
        itemBuilder: (context, index) {
          final p = store.plants[index];
          return PlantListItem(
            plant: p,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PlantDetailPage(id: p.id)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditPlantPage())),
        child: const Icon(Icons.add),
      ),
    );
  }
}