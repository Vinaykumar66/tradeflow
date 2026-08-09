import 'package:uuid/uuid.dart';
import '../../../core/constants/table_constants.dart';
import '../../../core/interfaces/i_customer_repository.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/customer.dart';

class CustomerRepository implements ICustomerRepository {
  final _uuid = const Uuid();

  @override
  Future<Customer> createCustomer(Customer customer) async {
    final id = customer.id.isEmpty ? _uuid.v4() : customer.id;
    final map = {...customer.toInsertMap(), 'id': id};
    await supabase.from(SupabaseTables.customers).insert(map);
    return customer.copyWith(id: id);
  }

  @override
  Future<Customer?> getCustomer(String businessId, String customerId) async {
    final d = await supabase
        .from(SupabaseTables.customers)
        .select()
        .eq('business_id', businessId)
        .eq('id', customerId)
        .maybeSingle();
    return d == null ? null : CustomerX.fromMap(d);
  }

  @override
  Stream<List<Customer>> streamCustomers(String businessId) {
    return supabase
        .from(SupabaseTables.customers)
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .map((rows) => rows.map(CustomerX.fromMap).toList());
  }

  @override
  Stream<List<Customer>> streamOverdueCustomers(String businessId) {
    // Customers with outstanding greater than credit limit
    return streamCustomers(businessId)
        .map((list) => list.where((c) => c.isOverCreditLimit).toList());
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await supabase
        .from(SupabaseTables.customers)
        .update(customer.toInsertMap())
        .eq('id', customer.id);
  }

  @override
  Future<void> archiveCustomer(String businessId, String customerId) async {
    await supabase
        .from(SupabaseTables.customers)
        .update({'is_active': false}).eq('id', customerId);
  }
}
