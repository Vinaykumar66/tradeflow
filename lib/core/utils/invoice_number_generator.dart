// Format tokens:
//   {PREFIX}   — businesses.invoice_prefix  e.g. INV
//   {YEAR}     — current 4-digit year        e.g. 2026
//   {MONTH}    — current 2-digit month       e.g. 08
//   {SEQ:N}    — sequence padded to N digits e.g. {SEQ:4} → 0001
//
// Default format stored in businesses.invoice_number_format:
//   "{PREFIX}/{YEAR}/{SEQ:4}"  →  INV/2026/0001
//
// Admin can change format in Business Settings screen.

class InvoiceNumberGenerator {
  static String generate({
    required String format,
    required String prefix,
    required int sequence,
  }) {
    final now = DateTime.now();
    String result = format;
    result = result.replaceAll('{PREFIX}', prefix);
    result = result.replaceAll('{YEAR}', now.year.toString());
    result = result.replaceAll('{MONTH}', now.month.toString().padLeft(2, '0'));
    //Handle seq: N with padding
    final seqPattern = RegExp(r'\{SEQ:(\d+)\}');
    result = result.replaceAllMapped(seqPattern, (m) {
      final pad = int.tryParse(m.group(1) ?? '4') ?? 4;
      return sequence.toString().padLeft(pad, '0');
    });
    //Fallback: plain {SEQ}
    result = result.replaceAll('{SEQ}', sequence.toString());
    return result;
  }

  //Format examples for Admin setting UI
  static List<InvoiceFormatExample> examples(String prefix) => [
        InvoiceFormatExample(
          label: 'Default',
          format: '{PREFIX}/{YEAR}/{SEQ:4}',
          preview: generate(
              format: '{PREFIX}/{YEAR}/{SEQ:4}', prefix: prefix, sequence: 1),
        ),
        InvoiceFormatExample(
          label: 'With Month',
          format: '{PREFIX}-{YEAR}{MONTH}-{SEQ:3}',
          preview: generate(
              format: '{PREFIX}-{YEAR}{MONTH}-{SEQ:3}',
              prefix: prefix,
              sequence: 1),
        ),
        InvoiceFormatExample(
          label: 'Simple',
          format: '{PREFIX}{SEQ:5}',
          preview:
              generate(format: '{PREFIX}{SEQ:5}', prefix: prefix, sequence: 1),
        ),
        InvoiceFormatExample(
          label: 'Year only',
          format: '{YEAR}-{SEQ:4}',
          preview:
              generate(format: '{YEAR}-{SEQ:4}', prefix: prefix, sequence: 1),
        ),
      ];
}

class InvoiceFormatExample {
  final String label, format, preview;
  const InvoiceFormatExample({
    required this.label,
    required this.format,
    required this.preview,
  });
}
