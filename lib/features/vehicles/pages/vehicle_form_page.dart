import 'package:autocare_brasil/features/vehicles/models/vehicle.dart';
import 'package:autocare_brasil/features/vehicles/repositories/vehicle_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    if (!_formKey.currentState!.validate()) return;

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

    // Em vez de pop(), navega diretamente para o Dashboard
    context.go('/dashboard');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veículo cadastrado com sucesso!'),
      ),
    );
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
              AppTextField(
                controller: _brandController,
                decoration: decoration('Marca'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a marca' : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _modelController,
                decoration: decoration('Modelo'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o modelo' : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _yearController,
                decoration: decoration('Ano'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o ano' : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _plateController,
                decoration: decoration('Placa'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a placa' : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _colorController,
                decoration: decoration('Cor'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a cor' : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _mileageController,
                decoration: decoration('Quilometragem'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a quilometragem'
                    : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: AppButton(
                  onPressed: _saveVehicle,
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