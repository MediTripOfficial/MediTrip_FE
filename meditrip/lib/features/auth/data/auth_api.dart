import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

class AuthApi {
  Future<Map<String, dynamic>> signupLocal({
    required String email,
    required String password,
    required String name,
    required String nickname,
    required double weight,
    required double height,
    required String birth,
    required String gender,
    required String country,
    required List<String> underlyingDisease,
    required List<String> allergies,
    required String profileImg,
    required String verifiedToken,
    required bool isMarketingTermsAgreed,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoints.signupLocal,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'nickname': nickname,
          'weight': weight,
          'height': height,
          'birth': birth,
          'gender': gender,
          'country': country,
          'underlyingDisease': underlyingDisease,
          'allergies': allergies,
          'profileImg': profileImg,
          'verifiedToken': verifiedToken,
          'isMarketingTermsAgreed': isMarketingTermsAgreed,
        },
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Signup failed');
    }
  }

  Future<Map<String, dynamic>> sendEmailVerification({
    required String email,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoints.sendEmailVerification,
        data: {'email': email.trim()},
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      print('TYPE: ${e.type}');
      print('ERROR: ${e.error}');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('MESSAGE: ${e.message}');

      throw Exception('Failed to send verification email');
    }
  }

  Future<String> checkEmailVerification({
    required String email,
    required String authCode,
  }) async {
    try {
      final response = await ApiClient.dio.patch(
        ApiEndpoints.checkEmailVerification,
        data: {'email': email, 'authCode': authCode},
      );

      return response.data['verifiedToken'] as String;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to verify email');
    }
  }
}
