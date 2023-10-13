import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';


class OrdersResource extends BaseResource {
  OrdersResource(super.client);

  /// Retrieves an order
  Future<Result<StoreOrdersRes, Failure>> retrieve(
      {required String id, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response =
          await client.get('/store/orders/$id');
      if (response.statusCode == 200) {
        return Success(StoreOrdersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Retrieves an order by cart id
  Future<Result<StoreOrdersRes, Failure>> retrieveByCartId(
      {required String cartId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client
          .get('/store/orders/cart/$cartId');
      if (response.statusCode == 200) {
        return Success(StoreOrdersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Look up an order using order details
  Future<Result<StoreOrdersRes, Failure>> lookupOrder(
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
          '/store/orders/cart/',
          queryParameters: queryParams);
      if (response.statusCode == 200) {
        return Success(StoreOrdersRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
