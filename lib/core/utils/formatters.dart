import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static final NumberFormat currencyFormatter = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );

  static final NumberFormat decimalCurrencyFormatter = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static final NumberFormat compactNumberFormatter = NumberFormat.compact();
  static final NumberFormat standardNumberFormatter = NumberFormat('#,###');

  static String formatCurrency(num value, {bool decimal = false}) {
    if (decimal) {
      return decimalCurrencyFormatter.format(value);
    }
    return currencyFormatter.format(value);
  }

  static String formatNumber(num value) {
    return standardNumberFormatter.format(value);
  }

  static String formatPercentage(double value, {bool includeSign = true}) {
    final prefix = includeSign && value > 0 ? '+' : '';
    return '$prefix${value.toStringAsFixed(1)}%';
  }
}
