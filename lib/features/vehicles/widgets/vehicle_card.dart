import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../models/vehicle.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.directions_car,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vehicle.brand} ${vehicle.model}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      vehicle.plate.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Chip(
                avatar: const Icon(Icons.calendar_today, size: 18),
                label: Text(vehicle.year.toString()),
              ),

              Chip(
                avatar: const Icon(Icons.palette, size: 18),
                label: Text(vehicle.color),
              ),

              Chip(
                avatar: const Icon(Icons.speed, size: 18),
                label: Text("${vehicle.mileage} km"),
              ),
            ],
          ),

          const Divider(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
                label: const Text("Editar"),
              ),

              const SizedBox(width: 12),

              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
                label: const Text("Excluir"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}