import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';

class SwapsResource extends BaseResource {
  SwapsResource(super.client);

  /// Creates a swap from a cart
  Future<Result<StoreSwapsRes, Failure>> create({StorePostSwapsReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.post('/store/swaps', data: req);
      if (response.statusCode == 200) {
        return Success(StoreSwapsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Retrieves a swap by cart id
  Future<Result<StoreSwapsRes, Failure>> retrieveByCartId(
      {required String cartId, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/swaps/$cartId',
      );
      if (response.statusCode == 200) {
        return Success(StoreSwapsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
