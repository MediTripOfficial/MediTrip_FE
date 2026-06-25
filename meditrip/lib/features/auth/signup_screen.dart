import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/auth_api.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthApi authApi = AuthApi();

  int step = 0;
  bool isSubmitting = false;
  String? signupError;

  bool agreeAll = false;
  bool agreeTerms = false;
  bool agreePrivacy = false;
  bool agreeMedical = false;
  bool agreeMarketing = false;

  String fullName = '';
  String nickName = '';
  String email = '';
  String verificationCode = '';
  String verifiedToken = 'TEMP_VERIFIED_TOKEN';

  String password = '';
  String confirmPassword = '';

  String birth = '';
  String gender = '';
  String country = '';

  String weight = '';
  String height = '';
  String condition = '';
  String allergy = '';

  bool get canNext {
    switch (step) {
      case 0:
        return agreeTerms && agreePrivacy && agreeMedical;
      case 1:
        return fullName.trim().isNotEmpty && nickName.trim().isNotEmpty;
      case 2:
        return email.trim().isNotEmpty && verificationCode.trim().isNotEmpty;
      case 3:
        return password.trim().length >= 6 && password == confirmPassword;
      case 4:
        return birth.trim().isNotEmpty &&
            gender.trim().isNotEmpty &&
            country.trim().isNotEmpty;
      case 5:
        return weight.trim().isNotEmpty &&
            height.trim().isNotEmpty &&
            condition.trim().isNotEmpty &&
            (condition != 'Allergies' || allergy.trim().isNotEmpty);
      case 6:
        return true;
      default:
        return false;
    }
  }

  void nextStep() {
    if (step == 5) {
      context.go('/signup-success');
      return;
    }

    setState(() {
      signupError = null;
      step++;
    });
  }

  void goToSuccessWithoutApi() {
    setState(() {
      signupError = null;
      step = 6;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      context.go('/home');
    });
  }

  Future<void> submitSignup() async {
    setState(() {
      isSubmitting = true;
      signupError = null;
    });

    try {
      final result = await authApi.signupLocal(
        email: email.trim(),
        password: password.trim(),
        name: fullName.trim(),
        nickname: nickName.trim(),
        weight: double.tryParse(weight.trim()) ?? 0.1,
        height: double.tryParse(height.trim()) ?? 0.1,
        birth: birth.trim(),
        gender: gender.trim(),
        country: country.trim(),
        underlyingDisease:
            condition.trim().isEmpty ||
                condition == 'None' ||
                condition == 'Allergies'
            ? []
            : [condition.trim()],
        allergies: condition == 'Allergies' && allergy.trim().isNotEmpty
            ? [allergy.trim()]
            : [],
        profileImg: '',
        verifiedToken: verifiedToken,
        marketingTermsAgreed: agreeMarketing,
      );

      final accessToken = result['accessToken'];
      final refreshToken = result['refreshToken'];

      debugPrint('accessToken: $accessToken');
      debugPrint('refreshToken: $refreshToken');

      if (!mounted) return;

      setState(() {
        step = 6;
      });
    } catch (e) {
      setState(() {
        signupError = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  void toggleAgreeAll(bool value) {
    setState(() {
      agreeAll = value;
      agreeTerms = value;
      agreePrivacy = value;
      agreeMedical = value;
      agreeMarketing = value;
    });
  }

  void syncAgreeAll() {
    agreeAll = agreeTerms && agreePrivacy && agreeMedical && agreeMarketing;
  }

  void showBirthPicker() {
    int selectedMonth = 4;
    int selectedDay = 12;
    int selectedYear = 2024;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return SizedBox(
          height: 360,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 56,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _NumberWheel(
                        title: 'Month',
                        start: 1,
                        end: 12,
                        initialItem: selectedMonth - 1,
                        onSelectedItemChanged: (value) {
                          selectedMonth = value + 1;
                        },
                      ),
                    ),
                    Expanded(
                      child: _NumberWheel(
                        title: 'Day',
                        start: 1,
                        end: 31,
                        initialItem: selectedDay - 1,
                        onSelectedItemChanged: (value) {
                          selectedDay = value + 1;
                        },
                      ),
                    ),
                    Expanded(
                      child: _NumberWheel(
                        title: 'Year',
                        start: 1900,
                        end: DateTime.now().year,
                        initialItem: DateTime.now().year - selectedYear,
                        reverse: true,
                        onSelectedItemChanged: (value) {
                          selectedYear = DateTime.now().year - value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        birth =
                            '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${selectedDay.toString().padLeft(2, '0')}';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Enter', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showGenderPicker() {
    showOptionBottomSheet(
      options: ['None', 'Male', 'Female', 'Other'],
      selectedValue: gender,
      onSelected: (value) {
        setState(() {
          gender = value;
        });
      },
    );
  }

  void showCountryPicker() {
    showOptionBottomSheet(
      options: [
        'China',
        'Japan',
        'U.S',
        'Korea',
        'Thailand',
        'Vietnam',
        'France',
      ],
      selectedValue: country,
      onSelected: (value) {
        setState(() {
          country = value;
        });
      },
    );
  }

  void showOptionBottomSheet({
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return SizedBox(
          height: 340,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 56,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = option == selectedValue;

                    return InkWell(
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 4,
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isSelected
                                ? const Color(0xFF0052FF)
                                : const Color(0xFF9AA3B2),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
          child: Column(
            children: [
              _Header(
                onBack: () {
                  if (step == 0) {
                    context.pop();
                  } else {
                    setState(() {
                      signupError = null;
                      step--;
                    });
                  }
                },
              ),
              const SizedBox(height: 34),
              Expanded(child: _buildStep()),
              if (signupError != null) ...[
                const SizedBox(height: 12),
                Text(
                  signupError!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ],
              const SizedBox(height: 12),
              _BottomButton(
                text: isSubmitting
                    ? 'Loading...'
                    : step == 6
                    ? 'Start'
                    : 'Next',
                enabled: !isSubmitting && canNext,
                onPressed: nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return _TermsStep();
      case 1:
        return _NameStep();
      case 2:
        return _EmailStep();
      case 3:
        return _PasswordStep();
      case 4:
        return _ProfileStep();
      case 5:
        return _HealthStep();
      case 6:
        return _SuccessStep();
      default:
        return const SizedBox();
    }
  }

  Widget _TermsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please agree to the terms\nand conditions to use the\nservice.',
          style: TextStyle(
            fontSize: 25,
            height: 1.3,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 36),
        _AgreementTile(
          title: 'Agree to All',
          value: agreeAll,
          onChanged: toggleAgreeAll,
        ),
        _AgreementTile(
          title: 'Agree to Terms of Service',
          required: true,
          value: agreeTerms,
          onChanged: (v) {
            setState(() {
              agreeTerms = v;
              syncAgreeAll();
            });
          },
        ),
        _AgreementTile(
          title: 'Consent to Collection and Use of\nInformation',
          required: true,
          value: agreePrivacy,
          onChanged: (v) {
            setState(() {
              agreePrivacy = v;
              syncAgreeAll();
            });
          },
        ),
        _AgreementTile(
          title: 'Consent to Provide Medical Data Logs',
          required: true,
          value: agreeMedical,
          onChanged: (v) {
            setState(() {
              agreeMedical = v;
              syncAgreeAll();
            });
          },
        ),
        _AgreementTile(
          title: 'Consent to Receive Marketing\nInformation',
          value: agreeMarketing,
          onChanged: (v) {
            setState(() {
              agreeMarketing = v;
              syncAgreeAll();
            });
          },
        ),
        const SizedBox(height: 34),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            'Required items are mandatory to use the service.\n'
            'Health data is used only for services; third-party sharing\n'
            'requires separate consent.\n'
            'Medical data is encrypted and stored securely.\n'
            'Withdraw consent anytime in My Page > Account Settings.',
            style: TextStyle(
              fontSize: 12,
              height: 1.35,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
      ],
    );
  }

  Widget _NameStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please enter your name and\nnickname to get started.',
          style: TextStyle(
            fontSize: 25,
            height: 1.3,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 34),
        _InputBox(
          key: const ValueKey('full_name_input'),
          label: 'Full name',
          hintText: 'Input',
          maxLength: 20,
          onChanged: (v) => setState(() => fullName = v),
        ),
        const SizedBox(height: 22),
        _InputBox(
          key: const ValueKey('nickname_input'),
          label: 'Nick name',
          hintText: 'Input',
          maxLength: 12,
          suffixText: 'Check',
          onChanged: (v) => setState(() => nickName = v),
        ),
      ],
    );
  }

  Widget _EmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please verify your email.',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 34),
        _InputBox(
          key: const ValueKey('email_input'),
          label: 'Email',
          hintText: 'Input your email',
          keyboardType: TextInputType.emailAddress,
          suffixText: 'Send',
          onChanged: (v) => setState(() => email = v),
        ),
        const SizedBox(height: 18),
        _InputBox(
          key: const ValueKey('verification_code_input'),
          label: 'Verification code',
          hintText: 'Input code',
          suffixText: 'Check',
          onChanged: (v) => setState(() {
            verificationCode = v;
            verifiedToken = v;
          }),
        ),
      ],
    );
  }

  Widget _PasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please set your password.',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 34),
        _InputBox(
          key: const ValueKey('password_input'),
          label: 'Password',
          hintText: 'At least 6 characters',
          obscureText: true,
          onChanged: (v) => setState(() => password = v),
        ),
        const SizedBox(height: 18),
        _InputBox(
          key: const ValueKey('confirm_password_input'),
          label: 'Confirm password',
          hintText: 'Input again',
          obscureText: true,
          onChanged: (v) => setState(() => confirmPassword = v),
        ),
        if (confirmPassword.isNotEmpty && password != confirmPassword) ...[
          const SizedBox(height: 8),
          const Text(
            'Passwords do not match.',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        ],
      ],
    );
  }

  Widget _ProfileStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please provide your basic\ndetails',
          style: TextStyle(
            fontSize: 25,
            height: 1.3,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 34),

        _SelectBox(
          key: const ValueKey('birth_select'),
          label: 'Date of birth',
          value: birth.isEmpty ? 'Text' : birth,
          onTap: showBirthPicker,
        ),
        const SizedBox(height: 18),

        _SelectBox(
          key: const ValueKey('gender_select'),
          label: 'Gender',
          value: gender.isEmpty ? 'Text' : gender,
          onTap: showGenderPicker,
        ),
        const SizedBox(height: 18),

        _SelectBox(
          key: const ValueKey('country_select'),
          label: 'Country',
          value: country.isEmpty ? 'Text' : country,
          onTap: showCountryPicker,
        ),
      ],
    );
  }

  Widget _HealthStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please enter your details for a\npersonalized health analysis.',
          style: TextStyle(
            fontSize: 23,
            height: 1.35,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 34),

        _SelectBox(
          key: const ValueKey('weight_height_select'),
          label: 'Weight/Height',
          value: weight.isEmpty || height.isEmpty
              ? 'Text'
              : '$weight / $height',
          onTap: showWeightHeightPicker,
        ),
        const SizedBox(height: 18),

        _SelectBox(
          key: const ValueKey('underlying_disease_select'),
          label: 'Underlying Disease',
          value: condition.isEmpty ? 'Text' : condition,
          onTap: showDiseasePicker,
        ),

        if (condition == 'Allergies') ...[
          const SizedBox(height: 12),
          _InputBox(
            key: const ValueKey('allergy_input'),
            label: 'Enter your Allergies',
            hintText: 'Enter Your Allergies',
            onChanged: (v) => setState(() => allergy = v),
          ),
        ],
      ],
    );
  }

  void showWeightHeightPicker() {
    int selectedWeight = int.tryParse(weight) ?? 78;
    int selectedHeight = int.tryParse(height) ?? 173;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return SizedBox(
          height: 360,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 56,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _NumberWheel(
                        title: 'Weight(kg)',
                        start: 20,
                        end: 200,
                        initialItem: selectedWeight - 20,
                        onSelectedItemChanged: (value) {
                          selectedWeight = 20 + value;
                        },
                      ),
                    ),
                    Expanded(
                      child: _NumberWheel(
                        title: 'Height(cm)',
                        start: 100,
                        end: 230,
                        initialItem: selectedHeight - 100,
                        onSelectedItemChanged: (value) {
                          selectedHeight = 100 + value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        weight = selectedWeight.toString();
                        height = selectedHeight.toString();
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Enter', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showDiseasePicker() {
    showOptionBottomSheet(
      options: [
        'None',
        'Pregnancy / Breastfeeding',
        'Cardiovascular Disease',
        'Diabetes',
        'Asthma',
        'Liver / Kidney Disease',
        'History of Gastric Ulcer or Gastrointestinal Bleeding',
        'Allergies',
        'Other',
      ],
      selectedValue: condition,
      onSelected: (value) {
        setState(() {
          condition = value;

          if (condition != 'Allergies') {
            allergy = '';
          }
        });
      },
    );
  }

  Widget _SuccessStep() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_rounded, size: 96, color: Color(0xFF0052FF)),
          SizedBox(height: 28),
          Text(
            'Sign Up Complete!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Welcome to MediTrip.',
            style: TextStyle(fontSize: 18, color: Color(0xFF9AA3B2)),
          ),
        ],
      ),
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _AgreementTile extends StatelessWidget {
  final String title;
  final bool value;
  final bool required;
  final ValueChanged<bool> onChanged;

  const _AgreementTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: title,
              style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
              children: [
                if (required)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
        const Icon(Icons.chevron_right_rounded, color: Color(0xFF6B7280)),
      ],
    );
  }
}

class _InputBox extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? suffixText;
  final ValueChanged<String>? onChanged;

  const _InputBox({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.maxLength,
    this.suffixText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        counterStyle: const TextStyle(color: Color(0xFF9AA3B2)),
        suffixIcon: suffixText == null
            ? null
            : Center(
                widthFactor: 1,
                child: Text(
                  suffixText!,
                  style: const TextStyle(
                    color: Color(0xFFD1D5DB),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFAAB2C0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFAAB2C0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF0052FF), width: 1.5),
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback onPressed;

  const _BottomButton({
    required this.text,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0052FF),
          disabledBackgroundColor: Colors.white.withOpacity(0.6),
          foregroundColor: Colors.white,
          disabledForegroundColor: const Color(0xFFD1D5DB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

class _SelectBox extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _SelectBox({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPlaceholder = value == 'Text';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 82,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFAAB2C0)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9AA3B2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isPlaceholder
                          ? const Color(0xFFD1D5DB)
                          : const Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 30,
              color: Color(0xFF9AA3B2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberWheel extends StatelessWidget {
  final String title;
  final int start;
  final int end;
  final int initialItem;
  final bool reverse;
  final ValueChanged<int> onSelectedItemChanged;

  const _NumberWheel({
    required this.title,
    required this.start,
    required this.end,
    required this.initialItem,
    required this.onSelectedItemChanged,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final values = List.generate(
      end - start + 1,
      (index) => reverse ? end - index : start + index,
    );

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            itemExtent: 42,
            diameterRatio: 1.4,
            perspective: 0.003,
            controller: FixedExtentScrollController(initialItem: initialItem),
            onSelectedItemChanged: onSelectedItemChanged,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: values.length,
              builder: (context, index) {
                return Center(
                  child: Text(
                    values[index].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF111827),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
