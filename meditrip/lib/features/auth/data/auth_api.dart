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
    required bool marketingTermsAgreed,
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
          'marketingTermsAgreed': marketingTermsAgreed,
        },
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Signup failed');
    }
  }
}
