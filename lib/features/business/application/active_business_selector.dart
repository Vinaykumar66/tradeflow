import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'active_business_selector.g.dart';

const _kPrefKeyActiveBusiness = 'active_business_id';

@riverpod
class ActiveBusinessSelector extends _$ActiveBusinessSelector {
  @override
  String? build() => null;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(_kPrefKeyActiveBusiness);
  }

  Future<void> select(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrefKeyActiveBusiness, businessId);
    state = businessId;
  }
}
