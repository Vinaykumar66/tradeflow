import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment.initial() = _Initial;
  const factory Payment.loading() = _Loading;
  const factory Payment.success({required String transactionId}) = _Success;
  const factory Payment.error({required String message}) = _Error;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
