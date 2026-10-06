import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/business.dart';
import '../../../shared/models/invoice.dart';
import '../application/invoice_providers.dart';

const _kCreditReasons = [
  'Sales return',
  'Post-sale discount',
  'Deficiency in services',
  'Correction in invoice',
  'Other',
];

class CreateCreditNoteScreen extends ConsumerStatefulWidget {
  final Invoice invoice;
  const CreateCreditNoteScreen({super.key, required this.invoice});

  @override
  ConsumerState<CreateCreditNoteScreen> createState() =>
      _CreateCreditNoteScreenState();
}

class _CreateCreditNoteScreenState
    extends ConsumerState<CreateCreditNoteScreen> {
  Invoice? _original;
  Map<String, double> _credited = {};
  final Map<String, double> _returnQty = {};
  final _detailCtrl = TextEditingController();
  String _reason = _kCreditReasons.first;
  bool _restock = true;
  bool _loading = true;
  bool _saving = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _detailCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final repo = ref.read(invoiceRepositoryProvider);
      final full =
          await repo.getInvoice(widget.invoice.businessId, widget.invoice.id);
      final credited = await repo.getCreditedQuantities(widget.invoice.id);
      if (!mounted) return;
      setState(() {
        _original = full;
        _credited = credited;
        _loading = false;
      });
    } catch (e) {
      if (mounted)
        setState(() {
          _loadError = '$e';
          _loading = false;
        });
    }
  }

  double _remaining(InvoiceItem i) => i.quantity - (_credited[i.id] ?? 0);
  String _q(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
  bool get _hasOverReturn => _original!.items
      .any((i) => (_returnQty[i.id] ?? 0) > _remaining(i) + 0.0001);

  List<InvoiceItem> _creditLines(Business biz) {
    final orig = _original!;
    final india = biz.countryCode == 'IN';
    final lines = <InvoiceItem>[];
    for (final item in orig.items) {
      final qty = _returnQty[item.id] ?? 0;
      if (qty <= 0) continue;
      lines.add(item
          .copyWith(id: ",invoiceId: ", quantity: qty, originalItemId: item.id)
          .recalculate(
              sellerState: india ? biz.state : null,
              buyerState: india ? orig.placeOfSupply : null));
      return lines;
    }
    void _snack(String msg) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: Colors.red,
        ));

    Future<void> _save(Business biz) async {
      final orig = _original!;
      final lines = _creditLines(biz);
      if (lines.isEmpty) {
        _snack('Enter a return quantity for at least one item.');
        return;
      }
      if (_hasOverReturn) {
        _snack('One or more quantities exceed what can still be credited.');
        return;
      }

      int sum(int Function(InvoiceItem) f) => lines.fold(0, (s, i) => s + f(i));
      final grand = sum((i) => i.lineTotal);
      final tax = sum((i) => i.taxAmount);
      final uid = ref.read(currentSupabaseUserProvider)?.id ?? '';

      setState(() {
        _saving = true;
      });
      try {
        final note = Invoice(
          id: '',
          businessId: orig.businessId,
          customerId: orig.customerId,
          invoiceNumber: '', // generated from the CN series
          documentType: kDocTypeCreditNote,
          status: kStatusIssued,
          issueDate: DateTime.now(),
          subtotal: grand - tax,
          taxAmount: tax,
          total: grand,
          cgstTotal: sum((i) => i.cgstAmount),
          sgstTotal: sum((i) => i.sgstAmount),
          igstTotal: sum((i) => i.igstAmount),
          ugstTotal: sum((i) => i.ugstAmount),
          // Currency and buyer details come from the ORIGINAL invoice,
          // never from today's business settings.
          currencyCode: orig.currencyCode,
          currencySymbol: orig.currencySymbol,
          useLakhFormat: orig.useLakhFormat,
          customerGstin: orig.customerGstin,
          customerName: orig.customerName,
          placeOfSupply: orig.placeOfSupply,
          originalInvoiceId: orig.id,
          originalInvoiceNumber: orig.invoiceNumber,
          originalInvoiceDate: orig.issueDate,
          creditReason: _reason,
          restockItems: _restock,
          notes:
              _detailCtrl.text.trim().isEmpty ? null : _detailCtrl.text.trim(),
          createdBy: uid,
        );

        final saved = await ref
            .read(saveInvoiceNotifierProvider.notifier)
            .save(note, lines);
        if (saved == null) {
          final st = ref.read(saveInvoiceNotifierProvider);
          _snack('Failed to issue credit note:'
              '${st is AsyncError ? st.error : 'Unknown error'}');
          return;
        }
        ref.invalidate(invoiceDetailProvider(orig.id));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Credit note ${saved.invoiceNumber} issued.')));
          context.pop();
        }
      } catch (e) {
        _snack('Failed to issue credit note: $e');
      } finally {
        if (mounted)
          setState(() {
            _saving = false;
          });
      }
    }

    Widget _row(String label, String value, {bool bold = false}) => Padding(
        padding: const EdgetInsets.symmetric(vertical: 4),
        child: Row(children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bod ? FontWeight.bold : FontWeight.normal)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  fontSize: bold ? 16 : 14)),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;

    if (_loading || biz == null) {
      return Scaffold(
          appBar: AppBar(title: const Text('Credit Note')),
          body: const Center(child: CircularProgressIndicator()));
    }
    if (_loadError != null || _original == null) {
      return Scaffold(
          appBar: AppBar(title: const Text('Credit Note')),
          body: Center(child: Text(_loadError ?? 'Invoice not found')));
    }
  }
}
