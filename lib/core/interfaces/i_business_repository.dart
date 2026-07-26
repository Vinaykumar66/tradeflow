import '../../shared/models/business.dart';
import '../../shared/models/business_member.dart';

abstract interface class IBusinessRepository {
  Future<Business> createBusiness({
    required String ownerUid,
    required String ownerName,
    required String ownerEmail,
    required String businessName,
    String? phone,
    String? gstin,
  });
  Future<Business?> getBusiness(String businessId);
  Future<void> updateBusiness(Business business);
  Future<List<Business>> getUserBusinesses(String uid);
  Future<BusinessMember?> getMember(String businessId, String uid);
  Future<List<BusinessMember>> getMembers(String businessId);
  Future<void> addMember(BusinessMember member);
  Future<void> updateMemberRole(
      {required String businessId,
      required String uid,
      required String newRole});
}
