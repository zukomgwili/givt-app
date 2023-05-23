import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:givt_app/core/network/interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class APIService {
  APIService() {
    apiURL = kDebugMode ? 'givt-debug-api.azurewebsites.net' : 'api.givt.app';
  }
  Client client = InterceptedClient.build(
    interceptors: [
      Interceptor(),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  late String apiURL;

  Future<dynamic> checkEmailExists(String email) async {
    final url = Uri.https(
      apiURL,
      '/api/v2/Users/check',
      {'email': email},
    );
    final response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Failed to check email');
    } else {
      return response.body;
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final url = Uri.https(apiURL, '/oauth2/token');
    final response = await client.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      encoding: Encoding.getByName('utf-8'),
    );
    if (response.statusCode >= 400) {
      throw Exception(jsonDecode(response.body));
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  Future<Map<String, dynamic>> refreshToken(Map<String, dynamic> body) async {
    final url = Uri.https(apiURL, '/oauth2/token');
    final response = await client.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      encoding: Encoding.getByName('utf-8'),
    );
    if (response.statusCode >= 400) {
      throw Exception('something went wrong :(');
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  Future<Map<String, dynamic>> getUserExtension(String guid) async {
    final url = Uri.https(apiURL, '/api/UsersExtension/$guid');
    final response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('something went wrong :(');
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }
}
