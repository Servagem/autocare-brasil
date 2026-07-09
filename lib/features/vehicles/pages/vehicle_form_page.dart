import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:autocare_brasil/features/vehicles/models/vehicle.dart';
import 'package:autocare_brasil/features/vehicles/repositories/vehicle_repository.dart';

class VehicleFormPage extends StatefulWidget {
  const VehicleFormPage({super.key});

  @override
  State<VehicleFormPage> createState() => _VehicleFormPageState();
}

class _VehicleFormPageState extends State<VehicleFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();
  final _colorController = TextEditingController();
  final _mileageController = TextEditingController();

  final _repository = VehicleRepository();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _colorController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }
Future<void> _saveVehicle() async {
  final vehicle = Vehicle(
    brand: _brandController.text.trim(),
    model: _modelController.text.trim(),
    year: int.tryParse(_yearController.text) ?? 0,
    plate: _plateController.text.trim(),
    color: _colorController.text.trim(),
    mileage: int.tryParse(_mileageController.text) ?? 0,
  );

  await _repository.insert(vehicle);

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Veículo cadastrado com sucesso!'),
    ),
  );

  context.pop();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _brandController,
                decoration: decoration('Marca'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _modelController,
                decoration: decoration('Modelo'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _yearController,
                decoration: decoration('Ano'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _plateController,
                decoration: decoration('Placa'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _colorController,
                decoration: decoration('Cor'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _mileageController,
                decoration: decoration('Quilometragem'),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    await _saveVehicle();
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}