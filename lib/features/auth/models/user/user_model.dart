import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    final String? id,
    final String? role,
    final List<String>? shifts,
    final List<String>? restaurants,
    final String? email,
    final String? name,
    final String? username,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    final String? password,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(
        json,
      );
}
