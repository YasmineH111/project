import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cabify/model/checkinternet.dart';
import 'package:cabify/model/statusrequest.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Crud {
  // Method for POST requests
  Future<Either<StatusRequest, Map<String, dynamic>>> postData(
    String linkurl,
    Map<String, dynamic> data, {
    String? authToken,
  }) async {
    try {
      if (await checkInternet()) {
        final headers = {
          "Content-Type": "application/json",
          if (authToken != null) "Token": authToken,
        };

        debugPrint("POST request to $linkurl");
        debugPrint("Headers: $headers");
        debugPrint("Request Body: ${jsonEncode(data)}");

        final response = await http.post(
          Uri.parse(linkurl),
          headers: headers,
          body: jsonEncode(data),
        );

        _logResponse(response); // Log response details
        return _handleMapResponse(response);
      } else {
        debugPrint("No internet connection.");
        return const Left(StatusRequest.offlinefailure);
      }
    } on SocketException catch (_) {
      debugPrint("Socket exception occurred.");
      return const Left(StatusRequest.offlinefailure);
    } on TimeoutException catch (_) {
      debugPrint("Request timeout.");
      return const Left(StatusRequest.offlinefailure);
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return const Left(StatusRequest.serverfailure);
    }
  }

  // Method for PUT requests
  Future<Either<StatusRequest, Map<String, dynamic>>> editData(
    String linkurl,
    Map<String, dynamic> data,
    String authToken,
  ) async {
    try {
      if (await checkInternet()) {
        final headers = {
          "Content-Type": "application/json",
          "Token": authToken,
        };

        debugPrint("PUT request to $linkurl");
        debugPrint("Headers: $headers");
        debugPrint("Request Body: ${jsonEncode(data)}");

        final response = await http.put(
          Uri.parse(linkurl),
          headers: headers,
          body: jsonEncode(data),
        );

        _logResponse(response); // Log response details
        return _handleMapResponse(response);
      } else {
        debugPrint("No internet connection.");
        return const Left(StatusRequest.offlinefailure);
      }
    } on SocketException catch (_) {
      debugPrint("Socket exception occurred.");
      return const Left(StatusRequest.offlinefailure);
    } on TimeoutException catch (_) {
      debugPrint("Request timeout.");
      return const Left(StatusRequest.offlinefailure);
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return const Left(StatusRequest.serverfailure);
    }
  }

  // Method for GET requests
  Future<Either<StatusRequest, List<dynamic>>> getData(
    String linkurl, {
    String? authToken,
  }) async {
    try {
      if (await checkInternet()) {
        final headers = {
          if (authToken != null) "Token": authToken,
        };

        debugPrint("GET request to $linkurl");
        debugPrint("Headers: $headers");

        final response = await http.get(
          Uri.parse(linkurl),
          headers: headers,
        );

        _logResponse(response); // Log response details
        return _handleListResponse(response);
      } else {
        debugPrint("No internet connection.");
        return const Left(StatusRequest.offlinefailure);
      }
    } on SocketException catch (_) {
      debugPrint("Socket exception occurred.");
      return const Left(StatusRequest.offlinefailure);
    } on TimeoutException catch (_) {
      debugPrint("Request timeout.");
      return const Left(StatusRequest.offlinefailure);
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return const Left(StatusRequest.serverfailure);
    }
  }

  // Method to log full response details
  void _logResponse(http.Response response) {
    debugPrint("Response Status Code: ${response.statusCode}");
    debugPrint("Response Headers: ${response.headers}");
    debugPrint("Response Body: ${response.body}");
  }

  // Handle responses for POST, PUT, DELETE methods
  Either<StatusRequest, Map<String, dynamic>> _handleMapResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } catch (e) {
          debugPrint("Response parsing failed: ${response.body}");
          return const Left(StatusRequest.serverfailure);
        }
      case 400:
        debugPrint("Client error: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.failure);
      case 401:
        debugPrint("Unauthorized: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.unauthorized);
      case 403:
        debugPrint("Forbidden: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.forbidden);
      case 404:
        debugPrint("Not Found: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.notfound);
      case 500:
        debugPrint("Server error: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.serverfailure);
      default:
        debugPrint("Unhandled status code: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.serverfailure);
    }
  }

  Either<StatusRequest, List<dynamic>> _handleListResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          final List<dynamic> responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } catch (e) {
          debugPrint("Response parsing failed: ${response.body}");
          return const Left(StatusRequest.serverfailure);
        }
      case 400:
        debugPrint("Client error: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.failure);
      case 401:
        debugPrint("Unauthorized: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.unauthorized);
      case 403:
        debugPrint("Forbidden: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.forbidden);
      case 404:
        debugPrint("Not Found: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.notfound);
      case 500:
        debugPrint("Server error: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.serverfailure);
      default:
        debugPrint("Unhandled status code: ${response.statusCode} - ${response.reasonPhrase}");
        return const Left(StatusRequest.serverfailure);
    }
  }
}
