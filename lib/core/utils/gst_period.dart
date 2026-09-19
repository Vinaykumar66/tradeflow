class GstPeriod {
  final DateTime start;
  final DateTime end;
  final String label;
  GstPeriod({required this.start, required this.end, required this.label});
}

class GstPeriodHelper {
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static GstPeriod monthOf(DateTime d) {
    final start = DateTime(d.year, d.month, 1);
    final end = DateTime(d.year, d.month + 1, 0, 23, 59, 59);

    return GstPeriod(
        start: start, end: end, label: '${_months[d.month - 1]} ${d.year}');
  }

  static GstPeriod currentMonth() {
    final now = DateTime.now();
    return monthOf(now);
  }

  static GstPeriod previousMonth(GstPeriod current) {
    return monthOf(DateTime(current.start.year, current.start.month - 1, 1));
  }

  static GstPeriod nextMonth(GstPeriod current) {
    return monthOf(DateTime(current.start.year, current.start.month + 1, 1));
  }
}
