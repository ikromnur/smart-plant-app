import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/hydroponic_plant.dart';

class EditPlantPage extends StatefulWidget {
  final HydroponicPlant? existing;
  const EditPlantPage({super.key, this.existing});

  @override
  State<EditPlantPage> createState() => _EditPlantPageState();
}

class _EditPlantPageState extends State<EditPlantPage> {
  final _form = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController room;
  late TextEditingController species;
  late TextEditingController imageUrl;

  double lumens = 300;
  double water = 50;
  double temp = 26;
  double ph = 6.5;
  int leaves = 5;
  int days = 1;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.existing?.name ?? '');
    room = TextEditingController(text: widget.existing?.room ?? '');
    species = TextEditingController(text: widget.existing?.species ?? '');
    imageUrl = TextEditingController(text: widget.existing?.imageUrl ?? 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6');
    if (widget.existing != null) {
      lumens = widget.existing!.lumens;
      water = widget.existing!.waterPercent;
      temp = widget.existing!.temperatureC;
      ph = widget.existing!.ph;
      leaves = widget.existing!.leafCount;
      days = widget.existing!.days;
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = AppState.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.existing == null ? 'Tambah Tanaman' : 'Edit Tanaman')),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Nama Tanaman'), validator: (v) => v==null||v.isEmpty? 'Wajib diisi': null),
          TextFormField(controller: room, decoration: const InputDecoration(labelText: 'Lokasi/Ruang'), validator: (v) => v==null||v.isEmpty? 'Wajib diisi': null),
          TextFormField(controller: species, decoration: const InputDecoration(labelText: 'Spesies'), validator: (v) => v==null||v.isEmpty? 'Wajib diisi': null),
          TextFormField(controller: imageUrl, decoration: const InputDecoration(labelText: 'URL Gambar')),
          const SizedBox(height: 12),
          _slider('Cahaya (Lumens)', lumens, 0, 1000, (v) => setState(() => lumens = v)),
          _slider('Sisa Air (%)', water, 0, 100, (v) => setState(() => water = v)),
          _slider('Suhu (C)', temp, 0, 60, (v) => setState(() => temp = v)),
          _slider('pH', ph, 0, 14, (v) => setState(() => ph = v)),
          _stepper('Jumlah Daun', leaves, (v) => setState(() => leaves = v)),
          _stepper('Hari Perawatan', days, (v) => setState(() => days = v)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_form.currentState!.validate()) {
                if (widget.existing == null) {
                  final id = DateTime.now().millisecondsSinceEpoch.toString();
                  store.add(HydroponicPlant(
                    id: id,
                    name: name.text,
                    room: room.text,
                    species: species.text,
                    days: days,
                    imageUrl: imageUrl.text,
                    leafCount: leaves,
                    lumens: lumens,
                    waterPercent: water,
                    temperatureC: temp,
                    ph: ph,
                    heightHistory: [HeightPoint(date: DateTime.now(), cm: 15)],
                  ));
                } else {
                  final updated = HydroponicPlant(
                    id: widget.existing!.id,
                    name: name.text,
                    room: room.text,
                    species: species.text,
                    days: days,
                    imageUrl: imageUrl.text,
                    leafCount: leaves,
                    lumens: lumens,
                    waterPercent: water,
                    temperatureC: temp,
                    ph: ph,
                    heightHistory: widget.existing!.heightHistory,
                  );
                  store.update(widget.existing!.id, updated);
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ]),
      ),
    );
  }

  Widget _slider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label),
      Slider(value: value, min: min, max: max, divisions: 100, label: value.toStringAsFixed(0), onChanged: onChanged),
    ]);
  }

  Widget _stepper(String label, int value, ValueChanged<int> onChanged) {
    return Row(children: [
      Expanded(child: Text(label)),
      IconButton(onPressed: () => onChanged(value-1 < 0 ? 0 : value-1), icon: const Icon(Icons.remove_circle_outline)),
      Text('$value'),
      IconButton(onPressed: () => onChanged(value+1), icon: const Icon(Icons.add_circle_outline)),
    ]);
  }
}