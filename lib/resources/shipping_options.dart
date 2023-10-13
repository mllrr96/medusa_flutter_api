import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';


class ShippingOptionsResource extends BaseResource {
  ShippingOptionsResource(super.client);

  /// Lists shipping options available for a cart
  Future<Result<StoreShippingOptionsListRes, Failure>> listCartOptions(
      {String? cartId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/shipping-options/$cartId',
      );
      if (response.statusCode == 200) {
        return Success(StoreShippingOptionsListRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Lists shipping options available
  Future<Result<StoreShippingOptionsListRes, Failure>> list(
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
          '/store/shipping-options',
          queryParameters: queryParams);
      if (response.statusCode == 200) {
        return Success(StoreShippingOptionsListRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
