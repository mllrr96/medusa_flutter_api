import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';


class CollectionsResource extends BaseResource {
  CollectionsResource(super.client);

  /// Retrieves a single collection
  Future<Result<StoreCollectionsRes, Failure>> retrieve(
      {required String id, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response =
          await client.get('/store/collections/$id');
      if (response.statusCode == 200) {
        return Success(StoreCollectionsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Retrieves a list of collections
  Future<Result<StoreCollectionsListRes, Failure>> list(
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/collections',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(StoreCollectionsListRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
