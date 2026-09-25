import 'package:freezed_annotation/freezed_annotation.dart';
part 'vendor.freezed.dart';
part 'vendor.g.dart';

@freezed
abstract class Vendor with _$Vendor {
  const factory Vendor({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    required String name,
    String? phone,
    String? email,
    String? gstin,
    String? address,
    String? city,
    String? state,
    @JsonKey(name: 'is_active') @Default(true) bool? isActive,
  }) = _Vendor;

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);
}

extension VendorX on Vendor {
  static Vendor fromMap(Map<String, dynamic> m) => Vendor.fromJson(m);
  Map<String, dynamic> toInsertMap() => {
        'business_id': businessId,
        'name': name,
        'phone': phone,
        'email': email,
        'gstin': gstin,
        'address': address,
        'city': city,
        'state': state,
        'is_active': isActive,
      };
}
