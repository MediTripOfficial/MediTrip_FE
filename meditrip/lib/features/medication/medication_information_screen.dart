import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/medication_item.dart';

class MedicationInformationScreen extends StatefulWidget {
  final MedicationItem medication;

  const MedicationInformationScreen({super.key, required this.medication});

  @override
  State<MedicationInformationScreen> createState() =>
      _MedicationInformationScreenState();
}

class _MedicationInformationScreenState
    extends State<MedicationInformationScreen> {
  bool isDetailsExpanded = false;
  bool isMarkedAsTaken = false;

  static const Color backgroundColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF566070);
  static const Color primaryBlue = Color(0xFF0049E6);

  @override
  Widget build(BuildContext context) {
    final medication = widget.medication;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 110),
                children: [
                  _buildNotice(),
                  const SizedBox(height: 26),

                  _buildMedicationHeader(medication),
                  const SizedBox(height: 14),

                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: medication.tags
                        .map(
                          (tag) =>
                              _DetailTag(text: tag, isPrimary: tag == 'Store'),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isMarkedAsTaken = !isMarkedAsTaken;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isMarkedAsTaken
                            ? const Color(0xFFE7F0FF)
                            : Colors.white,
                        foregroundColor: textDark,
                        side: BorderSide(
                          color: isMarkedAsTaken
                              ? primaryBlue
                              : const Color(0xFFD1D5DB),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        isMarkedAsTaken ? 'Taken' : 'Mark as Taken',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InformationSection(
                          title: 'Dosage & Interval',
                          content: medication.dosage,
                        ),
                        const SizedBox(height: 42),

                        _InformationSection(
                          title: 'Max Limit',
                          content: medication.maxLimit,
                        ),
                        const SizedBox(height: 42),

                        _InformationSection(
                          title: 'Caution',
                          content: medication.caution,
                          titleColor: const Color(0xFFE32323),
                        ),
                        const SizedBox(height: 42),

                        InkWell(
                          onTap: () {
                            setState(() {
                              isDetailsExpanded = !isDetailsExpanded;
                            });
                          },
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
                                  size: 32,
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ],
                          ),
                        ),

                        AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Text(
                              medication.details,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: textGray,
                              ),
                            ),
                          ),
                          crossFadeState: isDetailsExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 200),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/medication-options');
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
                'Medication Information',
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
        'This information is for reference only. Always consult a pharmacist. '
        'Not a prescription or diagnosis.',
        style: TextStyle(fontSize: 16, height: 1.35, color: Color(0xFF374151)),
      ),
    );
  }

  Widget _buildMedicationHeader(MedicationItem medication) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailMedicationImage(imageAsset: medication.imageAsset),
        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medication.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                medication.manufacturer,
                style: const TextStyle(fontSize: 18, color: Color(0xFF9AA3B2)),
              ),
              Text(
                medication.ingredient,
                style: const TextStyle(fontSize: 18, color: Color(0xFF9AA3B2)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      color: backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {
                  // 추후 약사 대화 문장 화면 연결
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 22),
                label: const Text('Phrases', style: TextStyle(fontSize: 17)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: textDark,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFD1D5DB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // 추후 지도 화면 연결
                  context.push('/map');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nearby Places', style: TextStyle(fontSize: 17)),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right_rounded, size: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailMedicationImage extends StatelessWidget {
  final String imageAsset;

  const _DetailMedicationImage({required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    if (imageAsset.isEmpty) {
      return Container(
        width: 90,
        height: 66,
        color: const Color(0xFFF3F4F6),
        child: const Icon(
          Icons.image_not_supported_outlined,
          color: Color(0xFFD1D5DB),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 90,
        height: 66,
        color: const Color(0xFFF8F9FB),
        child: Image.asset(
          imageAsset,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) {
            return const Icon(
              Icons.medication_rounded,
              size: 40,
              color: Color(0xFFEF4444),
            );
          },
        ),
      ),
    );
  }
}

class _DetailTag extends StatelessWidget {
  final String text;
  final bool isPrimary;

  const _DetailTag({required this.text, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

class _InformationSection extends StatelessWidget {
  final String title;
  final String content;
  final Color titleColor;

  const _InformationSection({
    required this.title,
    required this.content,
    this.titleColor = const Color(0xFF111827),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          content,
          style: const TextStyle(
            fontSize: 19,
            height: 1.35,
            color: Color(0xFF566070),
          ),
        ),
      ],
    );
  }
}
