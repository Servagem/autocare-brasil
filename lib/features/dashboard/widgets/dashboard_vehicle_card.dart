import 'package:flutter/material.dart';
import '../../vehicles/models/vehicle.dart';
import '../../../core/widgets/app_card.dart';

class DashboardVehicleCard extends StatelessWidget {
  final Vehicle? vehicle;

  const DashboardVehicleCard({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: vehicle == null
          ? const Column(
              children: [
                Icon(
                  Icons.directions_car,
                  size: 60,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  "Nenhum veículo cadastrado",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.directions_car),
                    SizedBox(width: 8),
                    Text(
                      "Meu Veículo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "${vehicle!.brand} ${vehicle!.model}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Placa: ${vehicle!.plate}"),
                Text("Ano: ${vehicle!.year}"),
                Text("${vehicle!.mileage} km"),
              ],
            ),
    );
  }
}