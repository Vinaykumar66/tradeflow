import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_repository.g.dart';

class PaymentRepository {
  final SupabaseClient _supabase;

  PaymentRepository(this._supabase);

  Future<void> savePaymentRecord({
    required String transactionId,
    required double amount,
    required String status,
  }) async {
    await _supabase.from('payments').insert({
      'transaction_id': transactionId,
      'amount': amount,
      'status': status,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}

@riverpod
PaymentRepository paymentRepository(PaymentRepositoryRef ref) {
  return PaymentRepository(Supabase.instance.client);
}
