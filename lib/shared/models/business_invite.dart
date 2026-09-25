import 'package:freezed_annotation/freezed_annotation.dart';
part 'business_invite.freezed.dart';
part 'business_invite.g.dart';

@freezed
abstract class BusinessInvite with _$BusinessInvite {
  const factory BusinessInvite({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    required String email,
    @JsonKey(name: 'role_value') required String roleValue,
    @JsonKey(name: 'invite_code') required String inviteCode,
    @Default('pending') String status,
    @JsonKey(name: 'expired_at') DateTime? expiersAt,
  }) = _BusinessInvite;
  factory BusinessInvite.fromJson(Map<String, dynamic> json) =>
      _$BusinessInviteFromJson(json);
}
