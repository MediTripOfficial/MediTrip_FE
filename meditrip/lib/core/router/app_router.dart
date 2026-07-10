import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/auth/signup_success_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/medication/medication_detail_screen.dart';
import '../../features/medication/medication_information_screen.dart';
import '../../features/medication/medication_options_screen.dart';
import '../../features/medication/models/medication_item.dart';
import '../../features/medication/recent_medication_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/symptom/symptom_analysis_result_screen.dart';
import '../../features/symptom/symptom_analyzing_screen.dart';
import '../../features/symptom/symptom_chat_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/signup-success',
      builder: (context, state) => const SignupSuccessScreen(),
    ),
    GoRoute(
      path: '/recent-medication-detail',
      builder: (context, state) => const MedicationDetailScreen(),
    ),
    GoRoute(
      path: '/recent-medication',
      builder: (context, state) {
        return const RecentMedicationScreen();
      },
    ),
    GoRoute(
      path: '/symptom-chat',
      builder: (context, state) {
        return const SymptomChatScreen();
      },
    ),
    GoRoute(
      path: '/symptom-analyzing',
      builder: (context, state) {
        final selectedSymptoms = state.extra as List<String>? ?? <String>[];

        return SymptomAnalyzingScreen(selectedSymptoms: selectedSymptoms);
      },
    ),

    GoRoute(
      path: '/symptom-analysis-result',
      builder: (context, state) {
        final selectedSymptoms = state.extra as List<String>? ?? <String>[];

        return SymptomAnalysisResultScreen(selectedSymptoms: selectedSymptoms);
      },
    ),
    GoRoute(
      path: '/medication-options',
      builder: (context, state) {
        return const MedicationOptionsScreen();
      },
    ),

    GoRoute(
      path: '/medication-information',
      builder: (context, state) {
        final medication = state.extra as MedicationItem?;

        if (medication == null) {
          return const MedicationOptionsScreen();
        }

        return MedicationInformationScreen(medication: medication);
      },
    ),
  ],
);
