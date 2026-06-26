import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MedicationDetailScreen extends StatelessWidget {
  const MedicationDetailScreen({super.key});

  static const Color bgColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF8F98A8);
  static const Color primaryBlue = Color(0xFF0049E6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                      color: textDark,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Recent Medications',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: textDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 34),

              const Text(
                'Medication Guide',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 86,
                          height: 58,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.medication_liquid_rounded,
                              size: 40,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tylenol',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: textDark,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Johnson & Johnson',
                                style: TextStyle(fontSize: 18, color: textGray),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Acetaminophen 500mg',
                                style: TextStyle(fontSize: 18, color: textGray),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _TagChip(text: 'Pain relief', isBlue: true),
                        _TagChip(text: 'Headache'),
                        _TagChip(text: 'Pharmacy & Convenience'),
                      ],
                    ),

                    const SizedBox(height: 42),

                    const _InfoSection(
                      title: 'Dosage & Interval',
                      content: '1~2 tablets per dose\nEvery 4~6 hours',
                    ),

                    const SizedBox(height: 38),

                    const _InfoSection(
                      title: 'Max Limit',
                      content: 'Do not exceed 8 tablets in 24 hours',
                    ),

                    const SizedBox(height: 38),

                    const _InfoSection(
                      title: 'Caution',
                      titleColor: Color(0xFFE32323),
                      content: 'Avoid with alcohol',
                    ),

                    const SizedBox(height: 38),

                    Row(
                      children: const [
                        Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 32,
                          color: textDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;
  final bool isBlue;

  const _TagChip({required this.text, this.isBlue = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: isBlue ? const Color(0xFFEAF1FF) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: isBlue ? const Color(0xFF0049E6) : const Color(0xFF374151),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String content;
  final Color titleColor;

  const _InfoSection({
    required this.title,
    required this.content,
    this.titleColor = MedicationDetailScreen.textDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          content,
          style: const TextStyle(
            fontSize: 21,
            height: 1.28,
            color: Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }
}
