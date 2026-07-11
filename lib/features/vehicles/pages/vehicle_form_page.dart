import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../models/vehicle.dart';
import '../repositories/vehicle_repository.dart';

class VehicleFormPage extends StatefulWidget {
  final Vehicle? vehicle;

  const VehicleFormPage({
    super.key,
    this.vehicle,
  });

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

  final VehicleRepository _repository = VehicleRepository();

  bool get isEditing => widget.vehicle != null;

  @override
  void initState() {
    super.initState();

    if (widget.vehicle != null) {
      _brandController.text = widget.vehicle!.brand;
      _modelController.text = widget.vehicle!.model;
      _yearController.text = widget.vehicle!.year.toString();
      _plateController.text = widget.vehicle!.plate;
      _colorController.text = widget.vehicle!.color;
      _mileageController.text = widget.vehicle!.mileage.toString();
    }
  }

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

  Future<void> _saveVehicle() async {
    if (!_formKey.currentState!.validate()) return;

    final vehicle = Vehicle(
      id: widget.vehicle?.id,
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      year: int.parse(_yearController.text),
      plate: _plateController.text.trim(),
      color: _colorController.text.trim(),
      mileage: int.parse(_mileageController.text),
    );

    if (isEditing) {
      await _repository.update(vehicle);
    } else {
      await _repository.insert(vehicle);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEditing
              ? "Veículo atualizado com sucesso!"
              : "Veículo cadastrado com sucesso!",
        ),
      ),
    );

    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: isEditing ? "Editar Veículo" : "Cadastrar Veículo",
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                controller: _brandController,
                label: "Marca",
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe a marca" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _modelController,
                label: "Modelo",
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o modelo" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _yearController,
                label: "Ano",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o ano" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _plateController,
                label: "Placa",
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe a placa" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _colorController,
                label: "Cor",
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe a cor" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _mileageController,
                label: "Quilometragem",
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? "Informe a quilometragem"
                    : null,
              ),

              const SizedBox(height: 30),

              AppButton(
                text: isEditing ? "Atualizar Veículo" : "Salvar Veículo",
                icon: isEditing ? Icons.edit : Icons.save,
                onPressed: _saveVehicle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}