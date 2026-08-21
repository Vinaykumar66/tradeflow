import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/invoice.dart';
part 'dashboard_providers.g.dart';

class DashboardStats {
  final int revenueToday;
  final int revenueWeek;
  final int revenueMonth;
  final int totalOutstanding;
  final int overdueAmount;
  final int invoiceCountMonth;
  final int lowStockCount;
  final int outOfStockCount;
  final int draftInvoiceCount;
  const DashboardStats({
    this.revenueToday = 0,
    this.revenueWeek = 0,
    this.revenueMonth = 0,
    this.totalOutstanding = 0,
    this.overdueAmount = 0,
    this.invoiceCountMonth = 0,
    this.lowStockCount = 0,
    this.outOfStockCount = 0,
    this.draftInvoiceCount = 0,
  });
}

@riverpod
Future<DashboardStats> dashboardStats(DashboardStatsRef ref) async {
//rebuild when business changes
  final biz = ref.watch(activeBusinessProvider).asData?.value;
  if (biz == null) return const DashboardStats();
  final bizId = biz.id;
  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day).toIso8601String();
  final weekStart = now
          .subtract(Duration(days: now.weekday - 1))
          .toLocal()
          .toString()
          .substring(0, 10) +
      'T00:00:00';
  final monthStart = DateTime(now.year, now.month, 1).toIso8601String();

  //Run all queries in parallel
  final results = await Future.wait([
    //Revenue today (paid invoices)
    _sumInvoices(bizId, todayStart, null, kStatusPaid),
    //Revnue this week
    _sumInvoices(bizId, weekStart, null, kStatusPaid),
    //Revenuw this month
    _sumInvoices(bizId, monthStart, null, kStatusPaid),
    //Total outstanding across alll customers
    _sumOutstanding(bizId),
    //Overdue amount
    _sumOverdue(bizId),
    //invoice count this month
    _countInvoices(bizId, monthStart),
    //Low stock products
    _countLowStock(bizId),
    //out of stock
    _countOutOfStock(bizId),
    //draft invoices
    _countDrafts(bizId),
  ]);
  return DashboardStats(
    revenueToday: results[0],
    revenueWeek: results[1],
    revenueMonth: results[2],
    totalOutstanding: results[3],
    overdueAmount: results[4],
    invoiceCountMonth: results[5],
    lowStockCount: results[6],
    outOfStockCount: results[7],
    draftInvoiceCount: results[8],
  );
}

Future<int> _sumInvoices(
    String bizId, String from, String? to, String status) async {
  var q = supabase
      .from('invoices')
      .select('total')
      .eq('business_id', bizId)
      .eq('status', status)
      .gte('created_at', from);
  if (to != null) q = q.lte('created_at', to);
  final rows = await q;
  return rows.fold<int>(0, (s, r) => s + ((r['total'] as num?)?.toInt() ?? 0));
}

Future<int> _sumOutstanding(String bizId) async {
  final rows = await supabase
      .from('customers')
      .select('outstanding')
      .eq('business_id', bizId)
      .eq('is_active', true)
      .gt('outstanding', 0);
  return rows.fold<int>(
      0, (s, r) => s + ((r['outstanding'] as num?)?.toInt() ?? 0));
}

Future<int> _sumOverdue(String bizId) async {
  final now = DateTime.now().toIso8601String();
  final rows = await supabase
      .from('invoices')
      .select('total, paid_amount')
      .eq('business_id', bizId)
      .lt('due_date', now)
      .not('status', 'in', '(${kStatusPaid},${kStatusCancelled})');
  return rows.fold<int>(
      0,
      (s, r) =>
          s +
          (((r['total'] as num?)?.toInt() ?? 0) -
              ((r['paid_amount'] as num?)?.toInt() ?? 0)));
}

Future<int> _countInvoices(String bizId, String from) async {
  final rows = await supabase
      .from('invoices')
      .select('id')
      .eq('business_id', bizId)
      .gte('created_at', from);
  return rows.length;
}

Future<int> _countLowStock(String bizId) async {
  final rows = await supabase
      .from('products')
      .select('id, stock_qty, reorder_level')
      .eq('business_id', bizId)
      .eq('is_active', true)
      .eq('track_inventory', true)
      .gt('stock_qty', 0);
  return rows
      .where((r) => (r['stock_qty'] as int) <= (r['reorder_level'] as int))
      .length;
}

Future<int> _countOutOfStock(String bizId) async {
  final rows = await supabase
      .from('products')
      .select('id')
      .eq('business_id', bizId)
      .eq('is_active', true)
      .eq('track_inventory', true)
      .lte('stock_qty', 0);
  return rows.length;
}

Future<int> _countDrafts(String bizId) async {
  final rows = await supabase
      .from('invoices')
      .select('id')
      .eq('business_id', bizId)
      .eq('status', kStatusDraft);
  return rows.length;
}
