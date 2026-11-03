import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradeflow/features/payments/application/payment_controller.dart';
import '../../../shared/models/payment.dart';
import '../data/payment_repository.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = ref.watch(paymentControllerProvider);
    bool _loading = true;
    // Listen for state changes to handle navigation or dialogs
    // ref.listen<AsyncValue<AppUser?>>(signUpNotifierProvider, (prev, next) {
    //   if (prev is! AsyncLoading) return;
    ref.listen<Payment>(paymentControllerProvider, (previous, next) {
      next.whenOrNull(success: (txnId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Successful! ID: $txnId')),
        );
        // Navigate to success or dashboard page
        Navigator.pop(context);
        _loading = false;
      }, error: ((message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: $message'), backgroundColor: Colors.red),
        );
      }));

      // error: (message) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content: Text('Error: $message'), backgroundColor: Colors.red),
      //   );
      // },
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Upgrade to Premium Billing Plan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),

              // Pay Button
              ElevatedButton(
                onPressed:
                    // _loading
                    //     ? null
                    //     :
                    () {
                  // Trigger payment workflow
                  ref.read(paymentControllerProvider.notifier).processPayment(
                        amount: 600.00,
                        gatewayType: 'Stripe/Razorpay',
                      );
                },
                child:
                    // _loading
                    // ? const CircularProgressIndicator(color: Colors.white)
                    const Text('Pay Now (₹600)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
