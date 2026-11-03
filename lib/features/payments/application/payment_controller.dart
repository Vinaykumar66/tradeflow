import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/models/payment.dart';
import '../data/payment_repository.dart';

part 'payment_controller.g.dart';

@riverpod
class PaymentController extends _$PaymentController {
  @override
  Payment build() {
    return const Payment.initial();
  }

  Future<void> processPayment(
      {required double amount, required String gatewayType}) async {
    state = const Payment.loading();

    try {
      final transactionId = await _executeGatewayCheckout(amount, gatewayType);

      if (transactionId == null) {
        state =
            const Payment.error(message: 'Payment was cancelled or failed.');
        return;
      }

      final repository = ref.read(paymentRepositoryProvider);
      await repository.savePaymentRecord(
        transactionId: transactionId,
        amount: amount,
        status: 'SUCCESS',
      );

      state = Payment.success(transactionId: transactionId);
    } catch (e) {
      state = Payment.error(message: e.toString());
    }
  }

  Future<String?> _executeGatewayCheckout(
      double amount, String gatewayType) async {
    // Simulated gateway delay and token generation
    await Future.delayed(const Duration(seconds: 2));
    return 'txn_${DateTime.now().millisecondsSinceEpoch}';
  }
}
