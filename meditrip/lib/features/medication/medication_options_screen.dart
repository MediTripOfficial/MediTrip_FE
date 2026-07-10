import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/medication_item.dart';

class MedicationOptionsScreen extends StatelessWidget {
  const MedicationOptionsScreen({super.key});

  static const Color backgroundColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF9AA3B2);
  static const Color primaryBlue = Color(0xFF0049E6);

  static const List<MedicationItem> medications = [
    MedicationItem(
      name: 'Tylenol',
      manufacturer: 'Johnson & Johnson',
      ingredient: 'Acetaminophen 500mg',
      imageAsset: 'assets/images/tylenol.png',
      rating: 4.5,
      reviewCount: 23,
      tags: ['Store', 'Pharmacy', 'Pain relief', 'Headache'],
      dosage: '1~2 tablets per dose\nEvery 4~6 hours',
      maxLimit: 'Do not exceed 8 tablets in 24 hours',
      caution: 'Avoid with alcohol',
      details:
          'Tylenol contains acetaminophen and may help reduce fever and relieve mild to moderate pain. Do not combine it with other medicines containing acetaminophen.',
    ),
    MedicationItem(
      name: 'Suspen',
      manufacturer: 'Hanmi',
      ingredient: 'Acetaminophen 500mg',
      imageAsset: 'assets/images/suspen.png',
      rating: 4.5,
      reviewCount: 23,
      tags: ['Pharmacy'],
      dosage: '1 tablet per dose\nEvery 4~6 hours',
      maxLimit: 'Follow the dosage written on the package',
      caution: 'Avoid taking with alcohol',
      details:
          'Check the package instructions and consult a pharmacist before taking this medicine.',
    ),
    MedicationItem(
      name: 'Tacenol',
      manufacturer: 'Bukwang Pharm',
      ingredient: 'Acetaminophen 500mg',
      imageAsset: '',
      rating: 4.5,
      reviewCount: 23,
      tags: ['Pharmacy'],
      dosage: '1 tablet per dose\nEvery 4~6 hours',
      maxLimit: 'Do not exceed the recommended daily dosage',
      caution: 'Avoid duplicate acetaminophen products',
      details:
          'This medicine contains acetaminophen. Ask a pharmacist if you are taking other pain relievers.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 40),
                children: [
                  _buildNotice(),
                  const SizedBox(height: 34),

                  const Text(
                    'Recommended for',
                    style: TextStyle(fontSize: 16, color: textDark),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Fever, Pain & Inflammation',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _SimilarDrugCard(medication: medications.first),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      const Text(
                        '4 Results',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: textDark,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        label: const Text(
                          'Recommended',
                          style: TextStyle(fontSize: 16, color: textDark),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: textDark,
                        ),
                        iconAlignment: IconAlignment.end,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  ...medications.map(
                    (medication) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _MedicationListCard(
                        medication: medication,
                        onTap: () {
                          context.push(
                            '/medication-information',
                            extra: medication,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/symptom-analysis-result');
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 23,
              color: textDark,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Medication Options',
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
    );
  }

  Widget _buildNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'This service does not provide diagnosis or prescription. '
        'Symptoms are categorized into general symptom categories to provide '
        'related medication information and pharmacist consultation phrases. '
        'Please consult a medical institution or pharmacist if symptoms are '
        'severe or persistent.',
        style: TextStyle(fontSize: 16, height: 1.35, color: Color(0xFF374151)),
      ),
    );
  }
}

class _SimilarDrugCard extends StatelessWidget {
  final MedicationItem medication;

  const _SimilarDrugCard({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Similar Drug from U.S.',
            style: TextStyle(fontSize: 16, color: Color(0xFF9AA3B2)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _MedicationImage(
                imageAsset: 'assets/images/paracap.png',
                width: 96,
                height: 64,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PARACAP',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      medication.manufacturer,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9AA3B2),
                      ),
                    ),
                    Text(
                      medication.ingredient,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9AA3B2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MedicationListCard extends StatelessWidget {
  final MedicationItem medication;
  final VoidCallback onTap;

  const _MedicationListCard({required this.medication, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MedicationImage(
                imageAsset: medication.imageAsset,
                width: 96,
                height: 68,
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.name,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      medication.manufacturer,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9AA3B2),
                      ),
                    ),
                    Text(
                      medication.ingredient,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9AA3B2),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 23,
                          color: Color(0xFFFFC400),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${medication.rating}(${medication.reviewCount})',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9AA3B2),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 7,
                      runSpacing: 7,
                      children: medication.tags
                          .take(2)
                          .map(
                            (tag) => _MedicationTag(
                              text: tag,
                              isPrimary: tag == 'Store',
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 48),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                  color: Color(0xFF9AA3B2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedicationImage extends StatelessWidget {
  final String imageAsset;
  final double width;
  final double height;

  const _MedicationImage({
    required this.imageAsset,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (imageAsset.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                color: Color(0xFFD1D5DB),
              ),
              Text(
                'No Image',
                style: TextStyle(fontSize: 12, color: Color(0xFFD1D5DB)),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        height: height,
        color: const Color(0xFFF8F9FB),
        child: Image.asset(
          imageAsset,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) {
            return const Icon(
              Icons.medication_rounded,
              color: Color(0xFFEF4444),
              size: 40,
            );
          },
        ),
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFE7F0FF) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: isPrimary ? const Color(0xFF3478FF) : const Color(0xFF374151),
        ),
      ),
    );
  }
}
