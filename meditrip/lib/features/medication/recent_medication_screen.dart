import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecentMedicationScreen extends StatefulWidget {
  const RecentMedicationScreen({super.key});

  @override
  State<RecentMedicationScreen> createState() => _RecentMedicationScreenState();
}

class _RecentMedicationScreenState extends State<RecentMedicationScreen> {
  bool isDetailsExpanded = false;

  static const Color backgroundColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF566070);
  static const Color primaryBlue = Color(0xFF0049E6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 40),

              const Text(
                'Medication Guide',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 22),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.96),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMedicationHeader(),
                    const SizedBox(height: 18),
                    _buildTags(),
                    const SizedBox(height: 44),

                    const _MedicationInfoSection(
                      title: 'Dosage & Interval',
                      description: '1~2 tablets per dose\nEvery 4~6 hours',
                    ),
                    const SizedBox(height: 42),

                    const _MedicationInfoSection(
                      title: 'Max Limit',
                      description: 'Do not exceed 8 tablets in 24 hours',
                    ),
                    const SizedBox(height: 42),

                    const _MedicationInfoSection(
                      title: 'Caution',
                      description: 'Avoid with alcohol',
                      titleColor: Color(0xFFE32323),
                    ),
                    const SizedBox(height: 42),

                    InkWell(
                      onTap: () {
                        setState(() {
                          isDetailsExpanded = !isDetailsExpanded;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: textDark,
                              ),
                            ),
                            const Spacer(),
                            AnimatedRotation(
                              turns: isDetailsExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 34,
                                color: Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Tylenol contains acetaminophen and is commonly '
                          'used to relieve mild to moderate pain and reduce fever. '
                          'Do not take it together with other medicines containing '
                          'acetaminophen.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: textGray,
                          ),
                        ),
                      ),
                      crossFadeState: isDetailsExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 220),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: textDark,
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Recent Medications',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: textDark,
              ),
            ),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildMedicationHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 112,
            height: 78,
            color: const Color(0xFFF8F9FB),
            child: Image.asset(
              'assets/images/tylenol.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.medication_rounded,
                  size: 48,
                  color: Color(0xFFEF4444),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 14),
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
                style: TextStyle(fontSize: 19, color: Color(0xFF9AA3B2)),
              ),
              SizedBox(height: 2),
              Text(
                'Acetaminophen 500mg',
                style: TextStyle(fontSize: 19, color: Color(0xFF9AA3B2)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTags() {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _MedicationTag(text: 'Pain relief', isPrimary: true),
        _MedicationTag(text: 'Headache'),
        _MedicationTag(text: 'Pharmacy & Convenience'),
      ],
    );
  }
}

class _MedicationTag extends StatelessWidget {
  final String text;
  final bool isPrimary;

  const _MedicationTag({required this.text, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFE7F0FF) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isPrimary ? const Color(0xFF3478FF) : const Color(0xFF374151),
        ),
      ),
    );
  }
}

class _MedicationInfoSection extends StatelessWidget {
  final String title;
  final String description;
  final Color titleColor;

  const _MedicationInfoSection({
    required this.title,
    required this.description,
    this.titleColor = RecentMedicationScreenStateColors.textDark,
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
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(
            fontSize: 20,
            height: 1.35,
            color: Color(0xFF566070),
          ),
        ),
      ],
    );
  }
}

class RecentMedicationScreenStateColors {
  static const Color textDark = Color(0xFF111827);
}
