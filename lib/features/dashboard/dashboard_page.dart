import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../vehicles/models/vehicle.dart';
import '../vehicles/repositories/vehicle_repository.dart';
import '../vehicles/widgets/vehicle_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final VehicleRepository _repository = VehicleRepository();

  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    final list = await _repository.getAll();

    if (!mounted) return;

    setState(() {
      vehicles = list;
    });
  }

  Future<void> deleteVehicle(int id) async {
    await _repository.delete(id);

    await loadVehicles();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veículo excluído com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AutoCare Brasil"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push('/vehicle');
          await loadVehicles();
        },
        child: const Icon(Icons.add),
      ),

      body: vehicles.isEmpty
          ? const Center(
              child: Text(
                "Nenhum veículo cadastrado",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];

                return VehicleCard(
                  vehicle: vehicle,

                  onEdit: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Editar veículo (próxima etapa)"),
                      ),
                    );
                  },

                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Excluir veículo"),
                        content: const Text(
                          "Deseja realmente excluir este veículo?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancelar"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Excluir"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true && vehicle.id != null) {
                      await deleteVehicle(vehicle.id!);
                    }
                  },
                );
              },
            ),
    );
  }
}