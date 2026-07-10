import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SymptomAnalysisResultScreen extends StatelessWidget {
  final List<String> selectedSymptoms;

  const SymptomAnalysisResultScreen({
    super.key,
    required this.selectedSymptoms,
  });

  static const Color backgroundColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color primaryBlue = Color(0xFF0049E6);

  @override
  Widget build(BuildContext context) {
    final result = _createResult(selectedSymptoms);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
          child: Column(
            children: [
              _Header(
                onBack: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/symptom-chat');
                  }
                },
              ),

              const SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _SymptomResultCard(
                        headerTitle: 'Primary Symptom',
                        headerColor: primaryBlue,
                        borderColor: primaryBlue,
                        title: result.primaryTitle,
                        subtitle: result.primarySubtitle,
                        tags: result.primaryTags,
                        isPrimary: true,
                      ),

                      const SizedBox(height: 18),

                      _SymptomResultCard(
                        headerTitle: 'Secondary Symptom',
                        headerColor: const Color(0xFFD1D5DB),
                        borderColor: Colors.transparent,
                        title: result.secondaryTitle,
                        subtitle: result.secondarySubtitle,
                        tags: result.secondaryTags,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                      '/medication-options',
                      extra: selectedSymptoms,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'View Medication Options',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _SymptomAnalysisResult _createResult(List<String> symptoms) {
    final normalized = symptoms.map((e) => e.toLowerCase()).toList();

    if (normalized.any(
      (item) => item.contains('fever') || item.contains('pain'),
    )) {
      return const _SymptomAnalysisResult(
        primaryTitle: 'Fever, Pain & Inflammation',
        primarySubtitle: 'General & Internal Pain',
        primaryTags: ['Headache', 'Body aches', 'Fever'],
        secondaryTitle: 'Fatigue & Tonic',
        secondarySubtitle: 'Travel Fatigue',
        secondaryTags: ['Tiredness', 'Weakness'],
      );
    }

    if (normalized.any((item) => item.contains('stomach'))) {
      return const _SymptomAnalysisResult(
        primaryTitle: 'Digestive Discomfort',
        primarySubtitle: 'Stomach & Digestive System',
        primaryTags: ['Stomach ache', 'Indigestion', 'Nausea'],
        secondaryTitle: 'Fatigue & Dehydration',
        secondarySubtitle: 'General Condition',
        secondaryTags: ['Weakness', 'Loss of appetite'],
      );
    }

    return const _SymptomAnalysisResult(
      primaryTitle: 'Throat & Respiratory Symptoms',
      primarySubtitle: 'Upper Respiratory Discomfort',
      primaryTags: ['Sore throat', 'Cough', 'Cold'],
      secondaryTitle: 'Fatigue & Tonic',
      secondarySubtitle: 'General Fatigue',
      secondaryTags: ['Tiredness', 'Weakness'],
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;

  const _Header({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 42, minHeight: 42),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Color(0xFF111827),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Analyze Symptoms',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ),
        const SizedBox(width: 42),
      ],
    );
  }
}

class _SymptomResultCard extends StatelessWidget {
  final String headerTitle;
  final Color headerColor;
  final Color borderColor;
  final String title;
  final String subtitle;
  final List<String> tags;
  final bool isPrimary;

  const _SymptomResultCard({
    required this.headerTitle,
    required this.headerColor,
    required this.borderColor,
    required this.title,
    required this.subtitle,
    required this.tags,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: isPrimary ? 1.3 : 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              color: headerColor,
              child: Text(
                headerTitle,
                style: TextStyle(
                  color: isPrimary ? Colors.white : const Color(0xFF111827),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9AA3B2),
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: tags
                        .map(
                          (tag) => _ResultTag(text: tag, isPrimary: isPrimary),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultTag extends StatelessWidget {
  final String text;
  final bool isPrimary;

  const _ResultTag({required this.text, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFE8F0FF) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPrimary ? const Color(0xFF3478FF) : const Color(0xFF374151),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SymptomAnalysisResult {
  final String primaryTitle;
  final String primarySubtitle;
  final List<String> primaryTags;
  final String secondaryTitle;
  final String secondarySubtitle;
  final List<String> secondaryTags;

  const _SymptomAnalysisResult({
    required this.primaryTitle,
    required this.primarySubtitle,
    required this.primaryTags,
    required this.secondaryTitle,
    required this.secondarySubtitle,
    required this.secondaryTags,
  });
}
