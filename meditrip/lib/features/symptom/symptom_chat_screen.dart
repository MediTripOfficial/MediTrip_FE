import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SymptomChatScreen extends StatefulWidget {
  const SymptomChatScreen({super.key});

  @override
  State<SymptomChatScreen> createState() => _SymptomChatScreenState();
}

class _SymptomChatScreenState extends State<SymptomChatScreen> {
  final List<String> selectedSymptoms = [];

  static const Color backgroundColor = Color(0xFFF1F3F6);
  static const Color textDark = Color(0xFF111827);
  static const Color primaryBlue = Color(0xFF0049E6);

  final List<String> symptoms = const [
    'Fever & Pain',
    'Stomach Ache',
    'Throat & Cough',
  ];

  void selectSymptom(String symptom) {
    setState(() {
      selectedSymptoms.add(symptom);
    });
  }

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
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 120),
                children: [
                  const Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'What kind of symptoms do you have?',
                    style: TextStyle(fontSize: 18, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 34),

                  _AssistantSymptomCard(
                    symptoms: symptoms,
                    onSelected: selectSymptom,
                  ),

                  for (final symptom in selectedSymptoms) ...[
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFFAFC8FF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                        ),
                        child: Text(
                          symptom,
                          style: const TextStyle(fontSize: 16, color: textDark),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _AssistantSymptomCard(
                      symptoms: symptoms,
                      onSelected: selectSymptom,
                    ),
                  ],
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              color: backgroundColor,
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: selectedSymptoms.isEmpty
                      ? null
                      : () {
                          context.push(
                            '/symptom-analyzing',
                            extra: selectedSymptoms,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    disabledBackgroundColor: primaryBlue.withOpacity(0.45),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Analyze Symptoms',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.send_rounded, size: 22),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
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
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: textDark,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Enter symptoms',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _AssistantSymptomCard extends StatelessWidget {
  final List<String> symptoms;
  final ValueChanged<String> onSelected;

  const _AssistantSymptomCard({
    required this.symptoms,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Could you please select the\ncorresponding symptom?',
            style: TextStyle(
              fontSize: 19,
              height: 1.25,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 18),

          for (int index = 0; index < symptoms.length; index++) ...[
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () => onSelected(symptoms[index]),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFE5E7EB),
                  foregroundColor: const Color(0xFF111827),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  symptoms[index],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            if (index != symptoms.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
