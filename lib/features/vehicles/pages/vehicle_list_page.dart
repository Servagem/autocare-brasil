import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_scaffold.dart';
import '../models/vehicle.dart';
import '../repositories/vehicle_repository.dart';
import '../widgets/vehicle_card.dart';

class VehicleListPage extends StatefulWidget {
  const VehicleListPage({super.key});

  @override
  State<VehicleListPage> createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
  final VehicleRepository _repository = VehicleRepository();
  final TextEditingController _searchController = TextEditingController();

  List<Vehicle> _vehicles = [];
  List<Vehicle> _filteredVehicles = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
    _searchController.addListener(_filterVehicles);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadVehicles() async {
    final vehicles = await _repository.getAll();

    if (!mounted) return;

    setState(() {
      _vehicles = vehicles;
      _filteredVehicles = vehicles;
      _loading = false;
    });
  }

  void _filterVehicles() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredVehicles = _vehicles.where((vehicle) {
        return vehicle.brand.toLowerCase().contains(query) ||
            vehicle.model.toLowerCase().contains(query) ||
            vehicle.plate.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _newVehicle() async {
    await context.push('/vehicle');

    await _loadVehicles();
  }

  Future<void> _editVehicle(Vehicle vehicle) async {
    await context.push(
      '/vehicle',
      extra: vehicle,
    );

    await _loadVehicles();
  }

  Future<void> _deleteVehicle(Vehicle vehicle) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Excluir veículo"),
          content: Text(
            "Deseja realmente excluir ${vehicle.brand} ${vehicle.model}?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await _repository.delete(vehicle.id!);

    await _loadVehicles();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Veículo excluído com sucesso!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Meus Veículos",

      floatingActionButton: FloatingActionButton(
        onPressed: _newVehicle,
        child: const Icon(Icons.add),
      ),

      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Pesquisar veículo",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: _filteredVehicles.isEmpty
                      ? const Center(
                          child: Text(
                            "Nenhum veículo cadastrado",
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadVehicles,
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              90,
                            ),
                            itemCount: _filteredVehicles.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final vehicle = _filteredVehicles[index];

                              return VehicleCard(
                                vehicle: vehicle,
                                onEdit: () => _editVehicle(vehicle),
                                onDelete: () => _deleteVehicle(vehicle),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}