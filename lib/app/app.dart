import 'package:flutter/material.dart';

import 'router.dart';
import '../core/theme/app_theme.dart';

class AutoCareApp extends StatelessWidget {
  const AutoCareApp({super.key});

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