import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_roles.dart';

part 'business_member.freezed.dart';
part 'business_member.g.dart';

@freezed
abstract class BusinessMember with _$BusinessMember {
  const factory BusinessMember({
    required String uid,
    @JsonKey(name: 'business_id') required String businessId,
    required String name,
    required String email,
    @JsonKey(name: 'role_value') required String roleValue,
    @JsonKey(name: 'is_active') @Default(true) bool? isActive,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
  }) = _BusinessMember;
  factory BusinessMember.fromJson(Map<String, dynamic> json) =>
      _$BusinessMemberFromJson(json);
}

extension BusinessMemberX on BusinessMember {
  UserRole get role => UserRole.fromString(roleValue);
  static BusinessMember fromMap(Map<String, dynamic> m) =>
      BusinessMember.fromJson(m);
  Map<String, dynamic> toInsertMap() => {
        'uid': uid,
        'business_id': businessId,
        'name': name,
        'email': email,
        'role_value': roleValue,
        'is_active': isActive
      };
}
