import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/defult_api_response.dart';
import '../utilities/api_urls.dart';
import '../utilities/app_util.dart';
import '../utilities/api_status_response.dart';

enum HttpMethod { post, put, patch, get, delete }

class ApiException implements Exception {
  final int statusCode;
  final dynamic message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() {
    return 'ApiException{statusCode: $statusCode, message: $message}';
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ApiLayer {
  // static Future<Object> makeApiCall(dynamic request, String endpoint,
  //     {bool requireAccess = true,
  //       HTTP_METHODS method = HTTP_METHODS.post,
  //       String? userAccessToken}) async {
  //   try {
  //     final url = Uri.https(ApiUrls.base_url, endpoint);
  //     final body = request != null ? json.encode(request.toJson()) : null;
  //     final headers = _buildHeaders(requireAccess, userAccessToken);
  //
  //     AppUtils.debug("/****rest call request starts****/");
  //     AppUtils.debug("url: $url");
  //     AppUtils.debug("headers: $headers");
  //     AppUtils.debug("body: $body");
  //
  //     final response = await _sendRequest(url, method, headers, body);
  //
  //     AppUtils.debug("/****call response starts****/");
  //     AppUtils.debug("status code: ${response.statusCode}");
  //     AppUtils.debug("response: ${response.body}");
  //
  //     return _handleResponse(response);
  //   } catch (e) {
  //     // return UnExpectedError();
  //     return Failure(500, e.toString());
  //   }
  // }

  static Future<dynamic> makeApiCall(
    String endpoint, {
    String baseUrl = ApiUrls.baseUrl,
    required HttpMethod method,
    Map<String, String>? headers,
    Object? body,
    bool requireAccess = false,
    String? userAccessToken,
  }) async {
    try {
      final url = Uri.https(baseUrl, endpoint);
      final requestHeaders =
          _buildHeaders(requireAccess, userAccessToken, headers);
      final response = await _sendRequest(url, method, requestHeaders, body);

      AppUtils.debug("/****API call response starts****/");
      AppUtils.debug("status code: ${response.statusCode}");
      AppUtils.debug("response: ${response.body}");

      return _handleResponse(response);
    } on HttpException {
      return NetWorkFailure();
    } on FormatException {
      return UnExpectedError();
    } on SocketException catch (e) {
      AppUtils.debug('Network error: $e');
      throw NetworkException(e.toString());
    } catch (e) {
      AppUtils.debug('Unexpected error: $e');
      rethrow;
    }
  }

  static Map<String, String> _buildHeaders(bool requireAccess,
      String? userAccessToken, Map<String, String>? additionalHeaders) {
    final headers = requireAccess
        ? {
            'Authorization': 'Bearer $userAccessToken',
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          }
        : {
          
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    return headers;
  }

  // static Future<http.Response> _sendRequest(Uri url, HTTP_METHODS method,
  //     Map<String, String> headers, [String? body]) async {
  //   var request = http.Request(method
  //       .toString()
  //       .split('.')
  //       .last, url);
  //   request.headers.addAll(headers);
  //   if (body != null) {
  //     request.body = body;
  //   }
  //   final streamedResponse = await request.send();
  //   return await http.Response.fromStream(streamedResponse);

  static Future<http.Response> _sendRequest(
      Uri url, HttpMethod method, Map<String, String> headers,
      [Object? body]) async {
    final request = http.Request(method.name, url);
    request.headers.addAll(headers);
    if (body != null) {
      request.body = json.encode(body);
    }
    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  // switch (method) {
  //   case HTTP_METHODS.post:
  //     return await http.post(url, headers: headers, body: body);
  //   case HTTP_METHODS.put:
  //     return await http.put(url, headers: headers, body: body);
  //   case HTTP_METHODS.patch:
  //     return await http.patch(url, headers: headers, body: body);
  //   case HTTP_METHODS.get:
  //     return await http.get(url, headers: headers);
  //   case HTTP_METHODS.delete:
  //     return await http.delete(url, headers: headers, body: body);
  //   default:
  //     throw UnsupportedError('Unsupported HTTP method');
  // }
  // }

  static Object _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return Success(response.statusCode, response.body);
      case 400:
        // return Failure(response.statusCode,
        //     defaultApiResponseFromJson(response.body).toString());
        return Failure(response.statusCode, response.body);
      case 401:
      case 403:
      case 404:
        return Failure(response.statusCode, response.body);
      case 500:
        return Failure(response.statusCode, 'Invalid Credentials');
      default:
        throw ApiException(response.statusCode, 'Error occurred');
    }
    //   switch (response.statusCode) {
    //     case ApiResponseCodes.success:
    //       return Success(response.statusCode, response.body);
    //     case ApiResponseCodes.error:
    //       return Failure(
    //           response.statusCode, (defaultApiResponseFromJson(response.body)));
    //     case ApiResponseCodes.authorizationError:
    //       return ForbiddenAccess();
    //     default:
    //       return Failure(response.statusCode, "Error Occurred");
    //   }
    // }
  }
}
