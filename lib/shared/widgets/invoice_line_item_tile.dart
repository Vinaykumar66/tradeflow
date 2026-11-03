import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradeflow/shared/utils/helper.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/models/invoice.dart';
import 'package:tradeflow/features/business/application/business_providers.dart'
    as activeBusinessProvider;

class InvoiceLineItemTile extends ConsumerStatefulWidget {
  final InvoiceItem item;
  final String sym;
  final bool lakh;
  final void Function(InvoiceItem) onUpdate;
  final VoidCallback onDelete;
  final bool showGstSplit;

  const InvoiceLineItemTile({
    super.key,
    required this.item,
    required this.sym,
    required this.lakh,
    required this.onUpdate,
    required this.onDelete,
    required this.showGstSplit,
  });

  @override
  ConsumerState<InvoiceLineItemTile> createState() =>
      _InvoiceLineItemTileState();
}

class _InvoiceLineItemTileState extends ConsumerState<InvoiceLineItemTile> {
  late final TextEditingController _qtyCtrl;
  late final TextEditingController _discCtrl;
  @override
  void initState() {
    super.initState();
    _qtyCtrl = TextEditingController(text: widget.item.quantity.toString());
    _discCtrl = TextEditingController(text: '%');
  }

// Runs whenever the parent passes a new `item` — e.g. a barcode
  // scan incrementing quantity. Only overwrite the field if the
  // value actually differs from what's already shown, so we never
  // fight the user's cursor while they're mid-keystroke.
  final FocusNode _qtyFocusNode = FocusNode();
  @override
  void didUpdateWidget(covariant InvoiceLineItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_qtyFocusNode.hasFocus) {
      final newText = widget.item.quantity.toString();

      if (_qtyCtrl.text != newText) {
        _qtyCtrl.text = newText;
      }
    }
  }

  @override
  void dispose() {
    _qtyFocusNode.dispose();
    _qtyCtrl.dispose();
    _discCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final fmt = (int v) =>
        CurrencyFormatter.format(v, sym: widget.sym, lakh: widget.lakh);
    final biz =
        ref.read(activeBusinessProvider.activeBusinessProvider).asData?.value;
    return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(widget.item.name,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    color: Colors.red, size: 18),
                onPressed: () async {
                  const title = 'Delete Item?';
                  const msg = 'Are you sure you want to delete this item?';
                  final shouldDelete = await onWillPop(context, title, msg);
                  if (shouldDelete == true) {
                    widget.onDelete();
                  }
                },
              ),
            ]),
            const SizedBox(height: 8),
            Text(
                item.taxRate <= 0
                    ? 'No tax'
                    : '${item.taxRate == item.taxRate.roundToDouble() ? item.taxRate.toStringAsFixed(0) : item.taxRate}% '
                        '${biz!.taxLabel} ${item.taxInclusive ? 'included in price' : 'added on top of Price'}',
                style: TextStyle(
                    fontSize: 11,
                    color: item.taxInclusive
                        ? Colors.green.shade700
                        : Colors.grey)),
            const SizedBox(height: 8),
            // Switch(
            //     value: item.taxInclusive,
            //     onChanged: (v) =>
            //         widget.onUpdate(item.copyWith(taxInclusive: v))),
            // const SizedBox(height: 8),
            Row(children: [
              // Quantity stepper
              _label('Quantity'),
              const SizedBox(width: 8),
//removed sized box to make the field flexible
              IntrinsicWidth(
                child: TextFormField(
                    controller: _qtyCtrl,
                    focusNode: _qtyFocusNode,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                    onChanged: (v) {
                      final q = double.tryParse(v);
                      if (q != null && q > 0)
                        widget.onUpdate(widget.item.copyWith(quantity: q));
                    }),
              ),
              // SizedBox(
              //     width: 72,
              //     child: TextFormField(
              //         initialValue: item.quantity.toString(),
              //         keyboardType:
              //             const TextInputType.numberWithOptions(decimal: true),
              //         decoration: const InputDecoration(
              //             isDense: true,
              //             contentPadding:
              //                 EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
              //         onChanged: (v) {
              //           final q = double.tryParse(v);
              //           if (q != null && q > 0)
              //             onUpdate(item.copyWith(quantity: q));
              //         })),
              const SizedBox(width: 16),
              // Unit price
              _label('Unit Price'),
              const SizedBox(width: 8),
              IntrinsicWidth(
                child: TextFormField(
                    // textAlign: TextAlign.end,
                    initialValue:
                        (widget.item.unitPrice / 100).toStringAsFixed(2),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                    onChanged: (v) {
                      final price = ((double.tryParse(v) ?? 0) * 100).round();
                      widget.onUpdate(widget.item.copyWith(unitPrice: price));
                    }),
              ),
              const SizedBox(width: 16),
              // discount
              _label('Discount'),
              const SizedBox(width: 8),
              IntrinsicWidth(
                child: TextFormField(
                    // controller: _discCtrl,
                    // textAlign: TextAlign.end,
                    initialValue: '0',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                    onChanged: (v) {
                      if (!v.isEmpty) {
                        final discAmt = _discCtrl.text == '%'
                            ? ((double.tryParse(v) ?? 0))
                            : (double.tryParse(v)! /
                                    (widget.item.unitPrice / 100)) *
                                100;
                        widget.onUpdate(
                            widget.item.copyWith(discountPct: discAmt));
                      } else {
                        widget.onUpdate(widget.item.copyWith(discountPct: 0));
                      }
                    }),
              ),
              const SizedBox(width: 4), // discount type
              IntrinsicWidth(
                child: TextFormField(
                  controller: _discCtrl,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                ),
              ),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              // Tax rate
              _label('Tax %'),
              const SizedBox(width: 8),
              SizedBox(
                  width: 60,
                  child: TextFormField(
                      initialValue: widget.item.taxRate.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                      onChanged: (v) {
                        final r = double.tryParse(v) ?? 0;
                        widget.onUpdate(widget.item.copyWith(taxRate: r));
                      })),
              const SizedBox(width: 8),
              // Tax inclusive toggle
              const Text('Incl.', style: TextStyle(fontSize: 12)),
              Switch(
                  value: widget.item.taxInclusive,
                  onChanged: (v) =>
                      widget.onUpdate(widget.item.copyWith(taxInclusive: v))),
              const Spacer(),
              // Line total

              widget.showGstSplit
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                          Text(fmt(item.lineTotal),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          if (item.cgstAmount > 0)
                            Text('CGST ${fmt(item.cgstAmount)}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          if (item.sgstAmount > 0)
                            Text('SGST ${fmt(item.sgstAmount)}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          if (item.ugstAmount > 0)
                            Text('UGST ${fmt(item.ugstAmount)}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          if (item.igstAmount > 0)
                            Text('IGST  ${fmt(item.igstAmount)}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                        ])
                  : Text(fmt(item.lineTotal),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),

              // Text(fmt(widget.item.lineTotal),
              //     style: const TextStyle(
              //         fontWeight: FontWeight.bold, fontSize: 15)),
            ]),
          ]),
        ));
  }

  Widget _label(String t) =>
      Text(t, style: const TextStyle(fontSize: 11, color: Colors.grey));
}
