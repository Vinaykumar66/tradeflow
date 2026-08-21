import 'package:freezed_annotation/freezed_annotation.dart';
part 'tax_code.freezed.dart';
part 'tax_code.g.dart';

@freezed
abstract class TaxCode with _$TaxCode {
  const factory TaxCode({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    required String name,
    required double rate,
    @JsonKey(name: 'is_inclusive') @Default(false) bool isInclusive,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _TaxCode;

  factory TaxCode.fromJson(Map<String, dynamic> json) =>
      _$TaxCodeFromJson(json);
}

extension TaxCodeX on TaxCode {
  static TaxCode fromMap(Map<String, dynamic> m) => TaxCode.fromJson(m);

  Map<String, dynamic> toInsertMap() => {
        'business_id': businessId,
        'name': name,
        'rate': rate,
        'is_inclusive': isInclusive,
        'is_default': isDefault,
        'is_active': isActive,
      };

  // Shown in dropdowns - e.g. "GST 18%" or "VAT 20% (incl.)"
  String get displayLabel =>
      name +
      ' ' +
      rate.toStringAsFixed(rate.truncateToDouble() == rate ? 0 : 2) +
      '%' +
      (isInclusive ? ' (incl.)' : '');
}
