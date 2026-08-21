import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/tax_code.dart';
part 'tax_code_providers.g.dart';

@riverpod
Stream<List<TaxCode>> taxCodeList(TaxCodeListRef ref) async* {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (bizId == null) {
    yield [];
    return;
  }
  yield* ref.read(taxCodeRepositoryProvider).streamTaxCodes(bizId);
}

@riverpod
class SaveTaxCodeNotifier extends _$SaveTaxCodeNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> save(TaxCode code) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (code.id.isEmpty) {
        await ref.read(taxCodeRepositoryProvider).createTaxCode(code);
      } else {
        await ref.read(taxCodeRepositoryProvider).updateTaxCode(code);
      }
    });
  }

  Future<void> archive(String id) =>
      ref.read(taxCodeRepositoryProvider).archiveTaxCode(id);

  Future<void> setDefault(String bizId, String id) =>
      ref.read(taxCodeRepositoryProvider).setDefault(bizId, id);
}
