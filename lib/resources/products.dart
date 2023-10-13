import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';


class ProductsResource extends BaseResource {
  ProductsResource(super.client);

  /// Retrieves a list of products
  Future<Result<StoreProductsListRes, Failure>> list(
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/products',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(StoreProductsListRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Retrieves a single Product
  Future<Result<StoreProductsRes, Failure>> retrieve(String id,
      {Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client.get(
        '/store/products/$id',
      );
      if (response.statusCode == 200) {
        return Success(StoreProductsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  /// Searches for products
  Future<Result<StorePostSearchRes, Failure>> search(
      {StorePostSearchReq? req, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client
          .post('/store/products/search', data: req);
      if (response.statusCode == 200) {
        return Success(StorePostSearchRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
