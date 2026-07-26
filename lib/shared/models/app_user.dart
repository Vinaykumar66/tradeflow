import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String name,
    required String email,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? phone,
    @Default('en') String locale,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _AppUser;
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

extension AppUserX on AppUser {
  static AppUser fromMap(Map<String, dynamic> m) => AppUser.fromJson(m);
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'photo_url': photoUrl,
        'phone': phone,
        'locale': locale,
      };
}
