import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/phrase_data.dart';
import 'models/phrase_item.dart';

class PhrasesScreen extends StatefulWidget {
  final String initialCategory;

  const PhrasesScreen({super.key, required this.initialCategory});

  @override
  State<PhrasesScreen> createState() => _PhrasesScreenState();
}

class _PhrasesScreenState extends State<PhrasesScreen> {
  static const Color backgroundColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF6B7280);

  static const List<String> categories = [
    'treatment',
    'conversation',
    'medication',
    'symptom',
  ];

  late String selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = categories.contains(widget.initialCategory)
        ? widget.initialCategory
        : 'treatment';
  }

  List<PhraseItem> get phrases =>
      PhraseData.data[selectedCategory] ?? const <PhraseItem>[];

  void playPhrase(PhraseItem phrase) {
    // 추후 TTS API 또는 flutter_tts 연결
    debugPrint('Play Korean phrase: ${phrase.korean}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildCategoryTabs(),
            const SizedBox(height: 18),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.82,
                ),
                itemCount: phrases.length,
                itemBuilder: (context, index) {
                  final phrase = phrases[index];

                  return _PhraseSentenceCard(
                    phrase: phrase,
                    onPlay: () => playPhrase(phrase),
                  );
                },
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
                context.go('/home');
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 42, minHeight: 42),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: textDark,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Phrases',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
            ),
          ),
          const SizedBox(width: 42),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 26),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return InkWell(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  PhraseData.title(category),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? textDark : const Color(0xFF9AA3B2),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: isSelected ? 110 : 0,
                  height: 1.5,
                  color: textDark,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PhraseSentenceCard extends StatelessWidget {
  final PhraseItem phrase;
  final VoidCallback onPlay;

  const _PhraseSentenceCard({required this.phrase, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phrase.english,
            style: const TextStyle(
              fontSize: 15,
              height: 1.35,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            phrase.korean,
            style: const TextStyle(
              fontSize: 19,
              height: 1.45,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: onPlay,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 42, minHeight: 42),
              icon: const Icon(
                Icons.volume_up_outlined,
                size: 32,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
