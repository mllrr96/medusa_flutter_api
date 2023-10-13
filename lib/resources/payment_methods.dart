import 'package:medusa_flutter/medusa_flutter.dart';
import 'package:medusa_flutter/resources/base.dart';
import 'package:multiple_result/multiple_result.dart';


class PaymentMethodsResource extends BaseResource {
  PaymentMethodsResource(super.client);

  /// Lists customer payment methods
  Future<Result<StoreCustomersListPaymentMethodsRes, Failure>> list(
      {Map<String, dynamic>? customHeaders}) async {
    try {
      if (customHeaders != null) {
        client.options.headers.addAll(customHeaders);
      }
      final response = await client
          .get('/store/customers/me/payment-methods');
      if (response.statusCode == 200) {
        return Success(StoreCustomersListPaymentMethodsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
