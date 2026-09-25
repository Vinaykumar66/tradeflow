import '../../shared/models/vendor.dart';

abstract interface class IVendorRepository {
  Stream<List<Vendor>> streamVendors(String businessId);
  Future<Vendor> createVendor(Vendor vendor);
  Future<void> updateVendor(Vendor vendor);
  Future<Vendor?> getVendor(String businessId, String vendorId);
}
