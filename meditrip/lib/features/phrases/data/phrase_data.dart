import '../models/phrase_item.dart';

class PhraseData {
  static const Map<String, List<PhraseItem>> data = {
    'treatment': [
      PhraseItem(
        english: 'Taking this on an empty stomach may cause heartburn.',
        korean: '빈속에 드시면 속이 쓰릴 수 있어요',
      ),
      PhraseItem(
        english: 'Consult a doctor if symptoms persist after 2-3 days.',
        korean: '2-3일 드셔보고 차도가 없으면 병원 가세요',
      ),
      PhraseItem(
        english: 'Drink plenty of water and get plenty of rest.',
        korean: '물을 충분히 마시고 푹 쉬세요',
      ),
      PhraseItem(
        english: 'Avoid spicy, irritating, or greasy foods.',
        korean: '자극적이거나 기름진 음식은 피하세요',
      ),
      PhraseItem(
        english: 'Do not take this with other cold medicines.',
        korean: '다른 감기약과 같이 드시면 안 돼요',
      ),
      PhraseItem(
        english: 'Discontinue use immediately if a rash or itchiness occurs.',
        korean: '발진이나 가려움이 생기면 바로 중단하세요',
      ),
    ],
    'conversation': [
      PhraseItem(
        english: "I'm a foreigner; could you recommend some medicine?",
        korean: '외국인인데 약 좀 추천해 주실 수 있나요?',
      ),
      PhraseItem(
        english: 'Are there any medicines I can buy without a prescription?',
        korean: '처방전 없이 살 수 있는 약 있나요?',
      ),
      PhraseItem(
        english: 'What is the most effective medicine for these symptoms?',
        korean: '이 증상에 가장 잘 듣는 약은 뭔가요?',
      ),
      PhraseItem(
        english: 'Do you have an instruction manual in English?',
        korean: '영어로 된 설명서 있나요?',
      ),
      PhraseItem(
        english: 'Is there a milder medicine than this?',
        korean: '이것보다 좀 더 순한 약 있나요?',
      ),
      PhraseItem(
        english: 'Could you write down how I should take it?',
        korean: '복용 방법을 적어 주실 수 있나요?',
      ),
    ],
    'medication': [
      PhraseItem(
        english: 'How many tablets should I take at once?',
        korean: '한 번에 몇 알 먹어야 하나요?',
      ),
      PhraseItem(
        english: 'How often should I take this medicine?',
        korean: '이 약은 몇 시간마다 먹어야 하나요?',
      ),
      PhraseItem(
        english: 'Should I take this before or after meals?',
        korean: '식전과 식후 중 언제 먹어야 하나요?',
      ),
      PhraseItem(
        english: 'Can I take this with my current medication?',
        korean: '제가 먹고 있는 약과 같이 복용해도 되나요?',
      ),
      PhraseItem(
        english: 'Does this medicine cause drowsiness?',
        korean: '이 약을 먹으면 졸릴 수 있나요?',
      ),
      PhraseItem(
        english: 'Are there any side effects I should know about?',
        korean: '주의해야 할 부작용이 있나요?',
      ),
    ],
    'symptom': [
      PhraseItem(
        english: 'I have a fever and body aches.',
        korean: '열이 나고 몸살 기운이 있어요',
      ),
      PhraseItem(
        english: 'My throat hurts when I swallow.',
        korean: '침을 삼킬 때 목이 아파요',
      ),
      PhraseItem(
        english: 'I have had a cough for three days.',
        korean: '3일째 기침이 계속되고 있어요',
      ),
      PhraseItem(
        english: 'I have a headache and feel dizzy.',
        korean: '머리가 아프고 어지러워요',
      ),
      PhraseItem(
        english: 'I have stomach pain and indigestion.',
        korean: '배가 아프고 소화가 잘 안 돼요',
      ),
      PhraseItem(
        english: 'I have an allergic reaction and a rash.',
        korean: '알레르기 반응과 발진이 생겼어요',
      ),
    ],
  };

  static String title(String category) {
    switch (category) {
      case 'treatment':
        return 'Treatment';
      case 'conversation':
        return 'Conversation';
      case 'medication':
        return 'Medication';
      case 'symptom':
        return 'Symptom';
      default:
        return 'Treatment';
    }
  }
}
