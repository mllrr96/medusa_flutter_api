import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';

class CartsResource extends BaseResource {
  CartsResource(super.client);

  /// Adds a shipping method to cart
  Future<Result<StoreCartsRes, Failure>> addShippingMethod(
      {required String cartId, StorePostCartsCartShippingMethodReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts/$cartId/shipping-methods', data: req);
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Completes a cart.
  /// Payment authorization is attempted and if more work is required, we simply return the cart for further updates.
  /// If payment is authorized and order is not yet created, we make sure to do so.
  /// The completion of a cart can be performed idempotently with a provided header Idempotency-Key.
  /// If not provided, we will generate one for the request.
  Future<Result<StoreCompleteCartRes, Failure>> complete(
      {required String cartId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts/$cartId/complete');
      if (response.statusCode == 200) {
        return Success(StoreCompleteCartRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Creates a cart
  /// @param {StorePostCartReq} payload is optional and can contain a region_id and items.
  /// The cart will contain the payload, if provided. Otherwise it will be empty
  Future<Result<StoreCartsRes, Failure>> create({StorePostCartReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts', data: req);
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Creates payment sessions.
  /// Initializes the payment sessions that can be used to pay for the items of the cart.
  /// This is usually called when a customer proceeds to checkout.
  Future<Result<StoreCartsRes, Failure>> createPaymentSessions(
      {required String cartId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts/$cartId/payment-sessions');
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Removes a discount from cart.
  Future<Result<StoreCartsRes, Failure>> deleteDiscount(
      {required String cartId, String? code, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.delete('/store/carts/$cartId/discounts/$code');
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Removes a payment session from a cart.
  /// Can be useful in case a payment has failed
  Future<Result<StoreCartsRes, Failure>> deletePaymentSession(
      {required String cartId, required String providerId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.delete('/store/carts/$cartId/payment-sessions/$providerId');
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Refreshes a payment session.
  Future<Result<StoreCartsRes, Failure>> refreshPaymentSession(
      {required String cartId, required String providerId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts/$cartId/payment-sessions/$providerId/refresh');
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Retrieves a cart
  Future<Result<StoreCartsRes, Failure>> retrieve({required String cartId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get('/store/carts/$cartId');
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Refreshes a payment session.
  Future<Result<StoreCartsRes, Failure>> setPaymentSession(
      {required String cartId,
      required StorePostCartsCartPaymentSessionReq? req,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts/$cartId/payment-sessions', data: req);
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Updates a cart
  Future<Result<StoreCartsRes, Failure>> update(
      {required String cartId, required StorePostCartsCartReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts/$cartId', data: req);
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Updates the payment method
  Future<Result<StoreCartsRes, Failure>> updatePaymentSession(
      {required String cartId,
      required String providerId,
      required Map<String, dynamic>? req,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/carts/$cartId/payment-sessions/$providerId', data: req);
      if (response.statusCode == 200) {
        return Success(StoreCartsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
