import 'package:flutter/material.dart';

class FuelFormPage extends StatelessWidget {
  const FuelFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Abastecimento'),
      ),
      body: const Center(
        child: Text(
          'Tela de cadastro de abastecimento',
        ),
      ),
    );
  }
}