import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/vendor.dart';
part 'vendor_providers.g.dart';

@riverpod
Stream<List<Vendor>> vendorList(VendorListRef ref) async* {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (bizId == null) {
    yield [];
    return;
  }
  yield* ref.read(vendorRepositoryProvider).streamVendors(bizId);
}

@riverpod
class SaveVendorNotifier extends _$SaveVendorNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> save(Vendor vendor) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (vendor.id.isEmpty) {
        await ref.read(vendorRepositoryProvider).createVendor(vendor);
      } else {
        await ref.read(vendorRepositoryProvider).updateVendor(vendor);
      }
    });
  }
}
