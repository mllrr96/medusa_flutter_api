import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';

class GiftCardsResource extends BaseResource {
  GiftCardsResource(super.client);

  /// Retrieves a single GiftCard
  Future<Result<StoreGiftCardsRes, Failure>> retrieve(
      {required String code, Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response =
          await client.get('/store/gift-cards/$code');
      if (response.statusCode == 200) {
        return Success(StoreGiftCardsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
