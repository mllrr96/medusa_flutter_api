import 'package:medusa_flutter/models/store/product_option.dart';
import 'package:medusa_flutter/models/store/product_variant.dart';

class ProductOptionValue {
  String? id;
  String? value;
  String? optionId;
  ProductOption? option;
  String? variantId;
  ProductVariant? variant;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Map<String, dynamic>? metadata;

  ProductOptionValue({
    this.id,
    required this.value,
    required this.optionId,
    this.option,
    required this.variantId,
    this.variant,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  ProductOptionValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    optionId = json['option_id'];
    option = json['option'] != null ? ProductOption.fromJson(json) : null;
    variantId = json['variant_id'];
    variant = json['variant'] != null ? ProductVariant.fromJson(json) : null;
    createdAt = DateTime.tryParse(json['created_at'] ?? '')?.toLocal();
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '')?.toLocal();
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '')?.toLocal();
    metadata = json['metadata'] ;
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['id'] = id;
    json['value'] = value;
    json['option_id'] = optionId;
    json['option'] = option?.toJson() ;
    json['variant_id'] = variantId;
    json['variant'] = variant?.toJson() ;
    json['created_at'] = createdAt.toString();
    json['updated_at'] = updatedAt.toString();
    json['deleted_at'] = deletedAt.toString();
    json['metadata'] = metadata;
    return json;
  }
}
