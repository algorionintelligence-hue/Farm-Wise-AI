import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  static const Duration _timeout = Duration(seconds: 10);

  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print('GET: $url');
    }

    try {
      final response = await http.get(Uri.parse(url)).timeout(_timeout);
      return _returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on FormatException {
      throw InvalidUrlException();
    }
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    if (kDebugMode) {
      print('POST: $url');
      print('BODY: ${jsonEncode(data)}');
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
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

  @override
  Future<dynamic> deleteApi(String url) async {
    if (kDebugMode) {
      print('DELETE: $url');
    }

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(_timeout);

      return _returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } on FormatException {
      throw InvalidUrlException();
    }
  }

  dynamic _returnResponse(http.Response response) {
    final responseBody = _decodeBody(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseBody;
      case 400:
      case 401:
      case 404:
        return responseBody;
      case 500:
        throw ServerException();
      default:
        throw FetchDataException(
          'Error occurred while communicating with server. Status code: ${response.statusCode}',
        );
    }
  }

  dynamic _decodeBody(String body) {
    if (body.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }
}
