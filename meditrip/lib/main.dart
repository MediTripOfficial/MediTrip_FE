import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

void main() {
  runApp(const MediTripApp());
}

class MediTripApp extends StatelessWidget {
  const MediTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MediTrip',
      routerConfig: appRouter,
      theme: ThemeData(
        fontFamily: 'NotoSans',
        scaffoldBackgroundColor: const Color(0xFFF1F3F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0052FF)),
      ),
    );
  }
}
