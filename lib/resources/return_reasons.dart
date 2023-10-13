import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';


class ReturnReasonsResource extends BaseResource {
  ReturnReasonsResource(super.client);

  /// Retrieves a single Return Reason
  Future<Result<StoreReturnReasonsRes, Failure>> retrieve(
      {required String id, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/return-reasons/$id',
      );
      if (response.statusCode == 200) {
        return Success(StoreReturnReasonsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Lists return reasons defined in Medusa Admin
  Future<Result<StoreReturnReasonsListRes, Failure>> list(
      {Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/return-reasons',
      );
      if (response.statusCode == 200) {
        return Success(StoreReturnReasonsListRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
