import 'dart:developer';

import 'package:medusa_flutter/resources/base.dart';

import '../models/res/cart.dart';

class CartsResource extends BaseResource {
  CartsResource(super.client);

  /// Adds a shipping method to cart
  /// @param {string} cart_id Id of cart
  /// @param {StorePostCartsCartShippingMethodReq} payload Containing id of shipping option and optional data
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> addShippingMethod(
    String cartId,
    Map<String, dynamic>? req,
    Map<String, dynamic>? headers,
  ) async {
    try {
      final response = await client.post(
          '${client.options.baseUrl}/store/carts/$cartId/shipping-methods',
          data: req);
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Completes a cart.
  /// Payment authorization is attempted and if more work is required, we simply return the cart for further updates.
  /// If payment is authorized and order is not yet created, we make sure to do so.
  /// The completion of a cart can be performed idempotently with a provided header Idempotency-Key.
  /// If not provided, we will generate one for the request.
  /// @param {string} cart_id is required
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCompleteCartRes>}
  Future<StoreCompleteCartRes?> complete(
    String cartId,
  ) async {
    try {
      final response = await client
          .post('${client.options.baseUrl}/store/carts/$cartId/complete');
      if (response.statusCode == 200) {
        return StoreCompleteCartRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Creates a cart
  /// @param {StorePostCartReq} payload is optional and can contain a region_id and items.
  /// The cart will contain the payload, if provided. Otherwise it will be empty
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> create({Map<String, dynamic>? req}) async {
    try {
      final response =
          await client.post('${client.options.baseUrl}/store/carts', data: req);
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Creates payment sessions.
  /// Initializes the payment sessions that can be used to pay for the items of the cart.
  /// This is usually called when a customer proceeds to checkout.
  /// @param {string} cart_id is required
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> createPaymentSessions(
    String cartId,
  ) async {
    try {
      final response = await client.post(
          '${client.options.baseUrl}/store/carts/$cartId/payment-sessions');
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Removes a discount from cart.
  /// @param {string} cart_id is required
  /// @param {string} code discount code to remove
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> deleteDiscount(
    String cartId,
    String code,
  ) async {
    try {
      final response = await client.delete(
          '${client.options.baseUrl}/store/carts/$cartId/discounts/$code');
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Removes a payment session from a cart.
  /// Can be useful in case a payment has failed
  /// @param {string} cart_id is required
  /// @param {string} provider_id the provider id of the session e.g. "stripe"
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> deletePaymentSession(
    String cartId,
    String providerId,
  ) async {
    try {
      final response = await client.delete(
          '${client.options.baseUrl}/store/carts/$cartId/payment-sessions/$providerId');
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Refreshes a payment session.
  /// @param {string} cart_id is required
  /// @param {string} provider_id the provider id of the session e.g. "stripe"
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> refreshPaymentSession(
    String cartId,
    String providerId,
  ) async {
    try {
      final response = await client.post(
          '${client.options.baseUrl}/store/carts/$cartId/payment-sessions/$providerId/refresh');
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Retrieves a cart
  /// @param {string} cart_id is required
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> retrieve(
    String cartId,
  ) async {
    try {
      final response =
          await client.get('${client.options.baseUrl}/store/carts/$cartId');
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Refreshes a payment session.
  /// @param {string} cart_id is required
  /// @param {StorePostCartsCartPaymentSessionReq} payload the provider id of the session e.g. "stripe"
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> setPaymentSession(
    String cartId,
    Map<String, dynamic>? req,
  ) async {
    try {
      final response = await client.post(
          '${client.options.baseUrl}/store/carts/$cartId/payment-sessions',
          data: req);
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
    }
  }

  /// Updates a cart
  /// @param {string} cart_id is required
  /// @param {StorePostCartsCartReq} payload is required and can contain region_id, email, billing and shipping address
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> update(
    String cartId,
    Map<String, dynamic>? req,
  ) async {
    try {
      final response = await client
          .post('${client.options.baseUrl}/store/carts/$cartId', data: req);
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  /// Updates the payment method
  /// @param {string} cart_id is required
  /// @param {string} provider_id is required
  /// @param {StorePostCartsCartPaymentSessionUpdateReq} payload is required
  /// @param customHeaders
  /// @return {ResponsePromise<StoreCartsRes>}
  Future<StoreCartsRes?> updatePaymentSession(
      String cartId, String providerId, Map<String, dynamic>? req) async {
    try {
      final response = await client.post(
          '${client.options.baseUrl}/store/carts/$cartId/payment-sessions/$providerId',
          data: req);
      if (response.statusCode == 200) {
        return StoreCartsRes.fromJson(response.data);
      } else {
        throw response.statusCode!;
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
