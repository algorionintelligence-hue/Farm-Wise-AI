import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'JwtTokenService.dart';
import 'AppExceptions.dart';
import 'BaseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  static const Duration _timeout = Duration(seconds: 10);


  Map<String, String> _authHeaders() {
    final token = JwtTokenService.getToken();

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ─────────────────────────────
  // PUBLIC HEADERS (NO JWT)
  // ─────────────────────────────
  Map<String, String> _publicHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // ─────────────────────────────
  // GET (AUTH REQUIRED)
  // ─────────────────────────────
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) print('GET: $url');

    try {
      final response = await http
          .get(Uri.parse(url), headers: _authHeaders())
          .timeout(_timeout);

      return _returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on FormatException {
      throw InvalidUrlException();
    }
  }

  // ─────────────────────────────
  // POST (AUTH REQUIRED)
  // ─────────────────────────────
  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    if (kDebugMode) {
      print('POST (AUTH): $url');
      print('BODY: ${jsonEncode(data)}');
    }

    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: _authHeaders(),
        body: jsonEncode(data),
      )
          .timeout(_timeout);

      return _returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on FormatException {
      throw InvalidUrlException();
    }
  }

  // ─────────────────────────────
  // PUBLIC POST (🔥 SIGNUP / LOGIN)
  // ─────────────────────────────
  Future<dynamic> postPublicApi(dynamic data, String url) async {
    if (kDebugMode) {
      print('POST (PUBLIC): $url');
      print('BODY: ${jsonEncode(data)}');
    }

    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: _publicHeaders(),
        body: jsonEncode(data),
      )
          .timeout(_timeout);

      return _returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on FormatException {
      throw InvalidUrlException();
    }
  }

  // ─────────────────────────────
  // DELETE (AUTH REQUIRED)
  // ─────────────────────────────
  @override
  Future<dynamic> deleteApi(String url) async {
    if (kDebugMode) print('DELETE: $url');

    try {
      final response = await http
          .delete(Uri.parse(url), headers: _authHeaders())
          .timeout(_timeout);

      return _returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on FormatException {
      throw InvalidUrlException();
    }
  }

  // ─────────────────────────────
  // RESPONSE HANDLER
  // ─────────────────────────────
  dynamic _returnResponse(http.Response response) {
    final body = _decodeBody(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return body;

      case 400:
      case 401:
      case 404:
        return body;

      case 500:
        throw ServerException();

      default:
        throw FetchDataException(
          'Server error: ${response.statusCode}',
        );
    }
  }

  // ─────────────────────────────
  // SAFE JSON DECODER
  // ─────────────────────────────
  dynamic _decodeBody(String body) {
    if (body.isEmpty) return null;

    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }

  @override
  Future<dynamic> updateApi(data, String url) async {
    if (kDebugMode) {
      print('PUT: $url');
      print('BODY: ${jsonEncode(data)}');
    }

    try {
      final response = await http
          .put(
        Uri.parse(url),
        headers: _authHeaders(),
        body: jsonEncode(data),
      )
          .timeout(_timeout);

      return _returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on FormatException {
      throw InvalidUrlException();
    }
  }
}