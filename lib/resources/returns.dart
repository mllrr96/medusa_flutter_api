import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';

class ReturnsResource extends BaseResource {
  ReturnsResource(super.client);

  /// Creates a return request
  Future<Result<StoreReturnsRes, Failure>> search(
      {StorePostReturnsReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client
          .post('`/store/returns', data: req);
      if (response.statusCode == 200) {
        return Success(StoreReturnsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
