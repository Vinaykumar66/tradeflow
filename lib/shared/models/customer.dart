import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    required String name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? gstin,
    // Credit limit in paise - e.g. 10,000 = 1000000 (currency fetched from businesses.currency_symbol)
    @JsonKey(name: 'credit_limit') @Default(0) int creditLimit,
    // Outstanding balance in paise - auto-updated by SQL trigger
    @JsonKey(name: 'outstanding') @Default(0) int outstanding,
    // Payment terms in days - 0 = cash on delivery
    @JsonKey(name: 'payment_terms') @Default(0) int paymentTerms,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

extension CustomerX on Customer {
  static Customer fromMap(Map<String, dynamic> m) => Customer.fromJson(m);

  Map<String, dynamic> toInsertMap() => {
        'business_id': businessId,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'gstin': gstin,
        'credit_limit': creditLimit,
        'payment_terms': paymentTerms,
      };

  // Formatted helpers
  String formattedOutstanding(String sym) =>
      '$sym ${(outstanding.abs() / 100).toStringAsFixed(2)}';
  String formattedCreditLimit(String sym) =>
      '$sym ${(creditLimit / 100).toStringAsFixed(2)}';

  // How much credit is still available
  int get availableCredit =>
      creditLimit == 0 ? 0 : (creditLimit - outstanding).clamp(0, creditLimit);
  String formattedAvailableCredit(String sym) =>
      '$sym ${(availableCredit / 100).toStringAsFixed(2)}';

  // Is customer over their credit limit?
  bool get isOverCreditLimit => creditLimit > 0 && outstanding > creditLimit;

  // Is there an outstanding balance?
  bool get hasOutstanding => outstanding > 0;
}
