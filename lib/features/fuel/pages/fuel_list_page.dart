import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FuelListPage extends StatelessWidget {
  const FuelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abastecimentos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/fuel/new');
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text(
          'Nenhum abastecimento cadastrado.',
        ),
      ),
    );
  }
}