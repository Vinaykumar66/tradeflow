// Handles two number grouping formats:
//   Indian (lakh): 1,00,000.00   — use_lakh_format = true
//   International: 100,000.00    — use_lakh_format = false

class CurrencyFormatter {
  /// Format [amountInSmallestUnit] to display string.
  /// [amountInSmallestUnit]: e.g. 9950 = 99.50
  /// [sym]: currency symbol from businesses.currency_symbol
  /// [lakh]: if true uses Indian grouping (1,00,000)
  static String format(
    int amountInSmallestUnit, {
    required String sym,
    bool lakh = false,
    int decimals = 2,
  }) {
    final value = amountInSmallestUnit / 100;
    final numStr =
        lakh ? _lakhFormat(value, decimals) : _intlFormat(value, decimals);
    return '$sym $numStr';
  }

  /// Format a double directly (use for tax rates, percentages)
  static String formatDouble(
    double value, {
    required String sym,
    bool lakh = false,
    int decimals = 2,
  }) {
    final numStr =
        lakh ? _lakhFormat(value, decimals) : _intlFormat(value, decimals);
    return '$sym $numStr';
  }

  /// Indian lakh grouping: 1,00,000.00
  static String _lakhFormat(double value, int decimals) {
    final parts = value.toStringAsFixed(decimals).split('.');
    final intPart = parts[0];
    final dec = parts.length > 1 ? '.${parts[1]}' : '';
    if (intPart.length <= 3) return '$intPart$dec';
    final last3 = intPart.substring(intPart.length - 3);
    final rest = intPart.substring(0, intPart.length - 3);
    final buf = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return '$buf,$last3$dec';
  }

  /// International grouping: 100,000.00
  static String _intlFormat(double value, int decimals) {
    final parts = value.toStringAsFixed(decimals).split('.');
    final intPart = parts[0];
    final dec = parts.length > 1 ? '.${parts[1]}' : '';
    final buf = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) buf.write(',');
      buf.write(intPart[i]);
    }
    return '$buf$dec';
  }
}



//commented to include international format with Indian format

// class CurrencyFormatter {
  
//   static String format(
//     int paise, {
//     String currencySymbol = 'Rs.',
//     bool useLakhFormat = true,
//   }) {
//     //convert smallest unit ot main unit(divide by 100)
//     final amount = paise / 100.0;
//     //Format the number with commas

//     final formatted =
//         useLakhFormat ? _formatLakh(amount) : _formatStandard(amount);
//     final needsSpace = currencySymbol.length > 2 && currencySymbol != 'Rs.';
//     return needsSpace
//         ? '$currencySymbol $formatted'
//         : 'currencySymbol$formatted';
//   }

// // _formatLakh: 1,00,000.00 style (India and Bangladesh)
//   // First comma after 2 digits from right (thousands),
//   // then every 2 digits: 1,00,00,000

//   static String _formatLakh(double amount) {
//     final parts = amount.toStringAsFixed(2).split('.');
//     final whole = parts[0];
//     final decimal = parts[1];
//     if (whole.length <=
//         3) // no comma necessary, ex: if the value was 12.500 then nothing is changed the same value is returned
//     {
//       return '$whole.$decimal';
//     }
//     //last 3 digirs stay together, rest split by 2
//     final last3 = whole.substring(whole.length - 3);
//     final rest = whole.substring(0, whole.length - 3);
//     final buffer = StringBuffer();
//     for (int i = 0; i < rest.length; i++) {
//       if (i > 0 && (rest.length - i) % 2 == 0) buffer.write(',');
//       buffer.write(rest[i]);
//     }
//     return '${buffer.toString()}, $last3.$decimal';
//   }

// // _formatStandard: 100,000.00 style (international)
//   static String _formatStandard(double amount) {
//     final parts = amount.toStringAsFixed(2).split('.');
//     final whole = parts[0];
//     final decimal = parts[1];
//     //add comma every 3 digits from right
//     final buffer = StringBuffer();
//     for (int i = 0; i < whole.length; i++) {
//       if (i > 0 && (whole.length - i) % 3 == 0) buffer.write(',');
//       buffer.write(whole[i]);
//     }
//     return '${buffer.toString()}.$decimal';
//   }
  // Quick reference for common countries:
  // format(50000, currencySymbol:'Rs.', useLakhFormat:true)  -> 'Rs.500.00'
  // format(50000, currencySymbol:'AED', useLakhFormat:false) -> 'AED 500.00'
  // format(50000, currencySymbol:'₦',   useLakhFormat:false) -> '₦500.00'
  // format(50000, currencySymbol:'৳',   useLakhFormat:true)  -> '৳500.00'
  // format(50000, currencySymbol:'LKR', useLakhFormat:false) -> 'LKR 500.00'
// }
