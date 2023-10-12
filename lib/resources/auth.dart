import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medusa_flutter/models/req/store_post_auth_req.dart';
import 'package:medusa_flutter/models/res/auth.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/common/failure.dart';

class AuthResource extends BaseResource {
  AuthResource(super.client);

  /// Authenticates a customer using email and password combination
  Future<Result<StoreAuthRes, Failure>> authenticate(
      {StorePostAuthReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      Response response = await client.post('/store/auth', data: req);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var cookie = response.headers['set-cookie']!.first.split(';').first;
        prefs.setString('Cookie', cookie);
        return Success(StoreAuthRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      return Error(Failure.from(error));
    }
  }

  /// Removes authentication session
  Future<bool> deleteSession({Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.delete(
        '/store/auth',
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      log(error.toString());
      return false;
    }
  }

  /// Retrieves an authenticated session
  /// Usually used to check if authenticated session is alive.
  Future<Result<StoreAuthRes, Failure>> getSession({Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/auth',
      );
      if (response.statusCode == 200) {
        return Success(StoreAuthRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (error) {
      log(error.toString());
      return Error(Failure.from(error));
    }
  }

  /// Check if email exists
  Future<Result<StoreGetAuthEmailRes, Failure>> emailExists(
      {required String email, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/auth/$email',
      );
      if (response.statusCode == 200) {
        return Success(StoreGetAuthEmailRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (error) {
      log(error.toString());
      return Error(Failure.from(error));
    }
  }
}
