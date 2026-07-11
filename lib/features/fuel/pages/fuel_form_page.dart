import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../vehicles/models/vehicle.dart';
import '../../vehicles/repositories/vehicle_repository.dart';
import '../models/fuel_record.dart';
import '../repositories/fuel_repository.dart';

class FuelFormPage extends StatefulWidget {
  const FuelFormPage({super.key});

  @override
  State<FuelFormPage> createState() => _FuelFormPageState();
}

class _FuelFormPageState extends State<FuelFormPage> {
  final _formKey = GlobalKey<FormState>();

  final VehicleRepository _vehicleRepository = VehicleRepository();
  final FuelRepository _fuelRepository = FuelRepository();

  List<Vehicle> vehicles = [];
  Vehicle? selectedVehicle;

  final stationController = TextEditingController();
  final mileageController = TextEditingController();
  final litersController = TextEditingController();
  final priceController = TextEditingController();

  String fuelType = 'Gasolina';
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  @override
  void dispose() {
    stationController.dispose();
    mileageController.dispose();
    litersController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> loadVehicles() async {
    final list = await _vehicleRepository.getAll();

    if (!mounted) return;

    setState(() {
      vehicles = list;

      if (vehicles.isNotEmpty) {
        selectedVehicle = vehicles.first;
      }
    });
  }

  Future<void> saveFuel() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedVehicle == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um veículo.'),
        ),
      );
      return;
    }

    final liters = double.parse(
      litersController.text.replaceAll(',', '.'),
    );

    final price = double.parse(
      priceController.text.replaceAll(',', '.'),
    );

    final total = liters * price;

    final fuel = FuelRecord(
      vehicleId: selectedVehicle!.id!,
      date: date,
      station: stationController.text,
      fuelType: fuelType,
      mileage: int.parse(mileageController.text),
      liters: liters,
      pricePerLiter: price,
      total: total,
    );

    await _fuelRepository.insert(fuel);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abastecimento salvo com sucesso!'),
      ),
    );

    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Novo Abastecimento",
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<Vehicle>(
                initialValue: selectedVehicle,
                decoration: const InputDecoration(
                  labelText: 'Veículo',
                  border: OutlineInputBorder(),
                ),
                items: vehicles.map((vehicle) {
                  return DropdownMenuItem<Vehicle>(
                    value: vehicle,
                    child: Text("${vehicle.brand} ${vehicle.model}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedVehicle = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: stationController,
                label: "Posto",
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: fuelType,
                decoration: const InputDecoration(
                  labelText: 'Combustível',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Gasolina",
                    child: Text("Gasolina"),
                  ),
                  DropdownMenuItem(
                    value: "Etanol",
                    child: Text("Etanol"),
                  ),
                  DropdownMenuItem(
                    value: "Diesel",
                    child: Text("Diesel"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      fuelType = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: mileageController,
                label: "Quilometragem",
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: litersController,
                label: "Litros",
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: priceController,
                label: "Preço por litro",
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              const SizedBox(height: 30),

              AppButton(
                text: "Salvar Abastecimento",
                icon: Icons.local_gas_station,
                onPressed: saveFuel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}