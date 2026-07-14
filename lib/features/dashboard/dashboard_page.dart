import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/statistic_card.dart';

import 'providers/dashboard_provider.dart';
import 'models/dashboard_data.dart';


class DashboardPage extends ConsumerWidget {

  const DashboardPage({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final dashboardState =
        ref.watch(dashboardControllerProvider);



    return AppScaffold(
      title: "AutoCare Brasil",

      body: dashboardState.when(

        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),


        error: (error, stack) => Center(
          child: Text(
            error.toString(),
          ),
        ),



        data: (dashboard) {


          return RefreshIndicator(

            onRefresh: () async {

              await ref
                  .read(dashboardControllerProvider.notifier)
                  .refresh();

            },


            child: ListView(

              padding: const EdgeInsets.all(20),

              children: [


                const Text(
                  "Bem-vindo 👋",
                  style: TextStyle(
                    fontSize:16,
                    color:Colors.grey,
                  ),
                ),


                const SizedBox(height:4),


                const Text(
                  "Seu painel de controle",
                  style:TextStyle(
                    fontSize:28,
                    fontWeight:FontWeight.bold,
                  ),
                ),



                const SizedBox(height:25),



                Row(

                  children:[


                    Expanded(
                      child: StatisticCard(
                        title:"Veículos",
                        value:
                        dashboard.totalVehicles.toString(),
                        icon:Icons.directions_car,
                        color:Colors.blue,
                      ),
                    ),


                    const SizedBox(width:12),


                    Expanded(
                      child: StatisticCard(
                        title:"Abastecimentos",
                        value:
                        dashboard.totalRefuels.toString(),
                        icon:Icons.local_gas_station,
                        color:Colors.green,
                      ),
                    ),


                  ],

                ),



                const SizedBox(height:12),



                Row(

                  children:[


                    Expanded(
                      child: StatisticCard(
                        title:"Gasto Total",
                        value:
                        "R\$ ${dashboard.totalSpent.toStringAsFixed(2)}",
                        icon:Icons.attach_money,
                        color:Colors.orange,
                      ),
                    ),



                    const SizedBox(width:12),


                    Expanded(
                      child: StatisticCard(
                        title:"Consumo",
                        value:
                        "${dashboard.averageConsumption.toStringAsFixed(1)} km/L",
                        icon:Icons.speed,
                        color:Colors.purple,
                      ),
                    ),


                  ],

                ),



                const SizedBox(height:30),



                const Text(
                  "Ações rápidas",
                  style:TextStyle(
                    fontSize:22,
                    fontWeight:FontWeight.bold,
                  ),
                ),



                const SizedBox(height:16),



                FilledButton.icon(

                  onPressed:() async {

                    await context.push('/vehicle');

                    ref.invalidate(
                      dashboardControllerProvider,
                    );

                  },


                  icon:const Icon(Icons.add),

                  label:const Text(
                    "Cadastrar Veículo",
                  ),

                ),



                const SizedBox(height:10),



                FilledButton.icon(

                  onPressed:() async {

                    await context.push('/fuel/new');

                    ref.invalidate(
                      dashboardControllerProvider,
                    );

                  },


                  icon:const Icon(
                    Icons.local_gas_station,
                  ),


                  label:const Text(
                    "Novo Abastecimento",
                  ),

                ),



                const SizedBox(height:10),



                FilledButton.icon(

                  onPressed:(){

                    context.push('/maintenance');

                  },


                  icon:const Icon(Icons.build),


                  label:const Text(
                    "Manutenções",
                  ),

                ),


              ],

            ),

          );

        },

      ),

    );

  }

}