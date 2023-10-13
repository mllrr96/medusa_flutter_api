import 'dart:developer';

import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';

class CustomersResource extends BaseResource {
  CustomersResource(super.client);

  /// Creates a customer
  Future<Result<StoreCustomersRes, Failure>> create(
      {StorePostCustomersReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client
          .post('/store/customers', data: req);
      if (response.statusCode == 200) {
        return Success(StoreCustomersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Retrieves the customer that is currently logged
  Future<Result<StoreCustomersRes, Failure>> retrieve(
      {Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/customers/me',
      );
      if (response.statusCode == 200) {
        return Success(StoreCustomersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Updates a customer
  Future<Result<StoreCustomersRes, Failure>> update(
      {StorePostCustomersCustomerReq? req,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client
          .post('/store/customers/me', data: req);
      if (response.statusCode == 200) {
        return Success(StoreCustomersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Retrieve customer orders
  Future<Result<StoreCustomersListOrdersRes, Failure>> listOrders(
      {Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/customers/me/orders',
      );
      if (response.statusCode == 200) {
        return Success(StoreCustomersListOrdersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Resets customer password
  Future<Result<StoreCustomersRes, Failure>> resetPassword(
      {StorePostCustomersCustomerPasswordTokenReq? req,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post(
          '/store/customers/password-reset',
          data: req);
      if (response.statusCode == 200) {
        return Success(StoreCustomersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Generates a reset password token, which can be used to reset the password.
  /// The token is not returned but should be sent out to the customer in an email.
  Future generatePasswordToken(
      {StorePostCustomersCustomerPasswordTokenReq? req,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post(
          '/store/customers/password-token',
          data: req);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response.statusCode!;
      }
    } catch (error,stackTrace) {
      log(error.toString(),stackTrace:stackTrace);
      rethrow;
    }
  }
}
