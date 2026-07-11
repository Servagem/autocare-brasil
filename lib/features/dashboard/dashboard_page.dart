import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_card.dart';
import '../../core/widgets/info_card.dart';
import 'models/dashboard_data.dart';
import 'services/dashboard_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardService _service = DashboardService();

  DashboardData? dashboard;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final data = await _service.loadDashboard();

    if (!mounted) return;

    setState(() {
      dashboard = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("AutoCare Brasil"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push('/vehicle');
          await loadDashboard();
        },
        child: const Icon(Icons.add),
      ),

      body: RefreshIndicator(
        onRefresh: loadDashboard,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.directions_car,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dashboard!.vehicleName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          dashboard!.plate,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    icon: Icons.local_gas_station,
                    title: "Consumo",
                    value:
                        "${dashboard!.averageConsumption.toStringAsFixed(1)} km/L",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: InfoCard(
                    icon: Icons.attach_money,
                    title: "Gasto do mês",
                    value:
                        "R\$ ${dashboard!.monthlyExpense.toStringAsFixed(2)}",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    icon: Icons.build,
                    title: "Próxima revisão",
                    value: "${dashboard!.nextMaintenanceKm} km",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: InfoCard(
                    icon: Icons.calendar_today,
                    title: "Último abastecimento",
                    value: dashboard!.lastFuelDate,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Resumo",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Em breve",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text("• Últimos abastecimentos"),

                  const SizedBox(height: 8),

                  const Text("• Gráfico de consumo"),

                  const SizedBox(height: 8),

                  const Text("• Gasto mensal"),

                  const SizedBox(height: 8),

                  const Text("• Próximas manutenções"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}