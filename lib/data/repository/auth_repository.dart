import 'dart:async';
import 'dart:io';

import 'package:bookand/config/app_config.dart';
import 'package:bookand/provider/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/social_type.dart';
import '../../const/storage_key.dart';
import '../../provider/secure_storage_provider.dart';
import '../model/token_response.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: '${AppConfig.instance.baseUrl}/auth', dio: dio, ref: ref);
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;
  final Ref ref;

  AuthRepository({required this.baseUrl, required this.dio, required this.ref});

  Future<TokenResponse> fetchLogin(
      {required String accessToken, required SocialType socialType}) async {
    final resp = await dio.post('$baseUrl/api/v1/auth/login',
        data: {'accessToken': accessToken, 'socialType': socialType.type});

    final data = resp.data['data'];
    return TokenResponse.fromJson(data);
  }

  // TODO: 사용자가 앱을 열 때, 1시간 마다 토큰 새로고침
  Future<void> updateToken(String accessToken, String refreshToken) async {
    final resp = await dio.post('$baseUrl/api/v1/auth/reissue',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'accessToken': accessToken}));

    final data = resp.data['data'];
    final token = TokenResponse.fromJson(data);

    ref.read(secureStorageProvider).write(key: accessTokenKey, value: token.accessToken);
    ref.read(secureStorageProvider).write(key: refreshTokenKey, value: token.refreshToken);
  }

  void logout(String accessToken) async {
    final resp = await dio.get('$baseUrl/api/v1/auth/logout',
        options: Options(headers: {'accessToken': accessToken}));

    if (resp.statusCode != HttpStatus.ok) {
      throw ('uri:${resp.realUri}::statusCode:${resp.statusCode}::body:${resp.data}');
    }
  }
}
