import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SymptomAnalyzingScreen extends StatefulWidget {
  final List<String> selectedSymptoms;

  const SymptomAnalyzingScreen({super.key, required this.selectedSymptoms});

  @override
  State<SymptomAnalyzingScreen> createState() => _SymptomAnalyzingScreenState();
}

class _SymptomAnalyzingScreenState extends State<SymptomAnalyzingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      context.go('/symptom-analysis-result', extra: widget.selectedSymptoms);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3477FF), Color(0xFFC9DCFF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Spacer(flex: 3),

                const Text(
                  'Analyzing your\nsymptoms...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    height: 1.35,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 20),

                Image.asset(
                  'assets/images/thermometer.png',
                  width: 170,
                  height: 250,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                const Text(
                  "We're identifying the most relevant symptom\n"
                  'category and preparing helpful guidance for you',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    height: 1.45,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
