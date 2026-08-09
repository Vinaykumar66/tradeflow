import '../../shared/models/customer.dart';

abstract interface class ICustomerRepository {
  Future<Customer> createCustomer(Customer customer);
  Future<Customer?> getCustomer(String businessId, String customerId);
  Stream<List<Customer>> streamCustomers(String businessID);
  Stream<List<Customer>> streamOverdueCustomers(String businessId);
  Future<void> updateCustomer(Customer customer);
  Future<void> archiveCustomer(String businessId, String customerId);
}
