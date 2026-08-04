import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/application/auth_providers.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen(supabaseAuthStateProvider, (_, __) => notifyListeners());
    // _ref.listen(activeBusinessIdProvider, (_, __) => notifyListeners());
  }
}
