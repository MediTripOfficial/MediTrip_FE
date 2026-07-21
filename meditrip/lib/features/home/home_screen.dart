import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryBlue = Color(0xFF0049E6);
  static const Color bgColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF8F98A8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.notifications_none_rounded,
                      size: 34,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 42),

                  _CurrentMedicationCard(),

                  const SizedBox(height: 24),

                  _SymptomCard(),

                  const SizedBox(height: 24),

                  _BannerCard(),

                  const SizedBox(height: 38),

                  const Text(
                    'Phrases',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5F6675),
                    ),
                  ),
                  const SizedBox(height: 12),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.15,
                    children: const [
                      _PhraseCard(
                        category: 'treatment',
                        iconAsset: 'assets/icons/treatment_icon.png',
                        title: 'Treatment',
                        description: 'Show phrases to your\ndoctor.',
                      ),
                      _PhraseCard(
                        category: 'conversation',
                        iconAsset: 'assets/icons/conversation_icon.png',
                        title: 'Conversation',
                        description:
                            'Useful phrases for clinic\nvisits and pharmacies.',
                      ),
                      _PhraseCard(
                        category: 'medication',
                        iconAsset: 'assets/icons/medication_icon.png',
                        title: 'Medication',
                        description: 'Medication related\nphrases.',
                      ),
                      _PhraseCard(
                        category: 'symptom',
                        iconAsset: 'assets/icons/symptom_icon.png',
                        title: 'Symptom',
                        description: 'Explain your symptoms\nmore clearly.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}

class _CurrentMedicationCard extends StatelessWidget {
  const _CurrentMedicationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Medications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 12),

          InkWell(
            onTap: () {
              context.push('/recent-medication');
            },
            borderRadius: BorderRadius.circular(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 112,
                    height: 72,
                    color: const Color(0xFFF8F9FB),
                    child: Image.asset(
                      'assets/images/tylenol.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) {
                        return const Icon(
                          Icons.medication_rounded,
                          size: 42,
                          color: Color(0xFFEF4444),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PurchasedBadge(),
                      SizedBox(height: 8),
                      Text(
                        'Tylenol',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Johnson & Johnson',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9AA3B2),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right_rounded,
                  size: 34,
                  color: Color(0xFF9AA3B2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: () {
                // 추후 리뷰 화면 연결
                // context.push('/write-review');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF111827),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFD1D5DB), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Write a Review',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchasedBadge extends StatelessWidget {
  const _PurchasedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'Purchased 2 days ago',
        style: TextStyle(
          fontSize: 13,
          color: Color(0xFF374151),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SymptomCard extends StatelessWidget {
  const _SymptomCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/symptom-chat');
      },
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          color: const Color(0xFF0049E6),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const Icon(Icons.sick_rounded, color: Colors.white, size: 40),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Where does it hurt?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Enter symptoms.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: Colors.white.withOpacity(0.95),
            ),
          ],
        ),
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE3EDFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Banner\nAdvertising',
              style: TextStyle(
                fontSize: 30,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0049E6),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                '03 / 28   More',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhraseCard extends StatelessWidget {
  final String category;
  final String iconAsset;
  final String title;
  final String description;

  const _PhraseCard({
    required this.category,
    required this.iconAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.95),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: () {
          context.push('/phrases/$category');
        },
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                iconAsset,
                width: 42,
                height: 42,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 40,
                    color: Color(0xFF111827),
                  );
                },
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.35,
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
