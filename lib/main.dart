import 'package:flutter/material.dart';

import 'app/router.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AutoCareBrasil());
}

class AutoCareBrasil extends StatelessWidget {
  const AutoCareBrasil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'AutoCare Brasil',

      theme: AppTheme.lightTheme,

      routerConfig: appRouter,
    );
  }
}