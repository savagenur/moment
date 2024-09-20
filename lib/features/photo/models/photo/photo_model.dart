import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/core/converters/file_json_converter.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';

part 'photo_model.g.dart';
part 'photo_model.freezed.dart';

@freezed
class PhotoModel with _$PhotoModel {
  const PhotoModel._();
  const factory PhotoModel({
    required final String? id,
    required final String? shiftId,
    required final PhotoType photoType,
    final String? userId,
    final String? userName,
    final String? restaurantName,
    required final DateTime? createdAt,
    final String? imageUrl,
    @JsonKey(includeToJson: false)
    @Default(false) final bool? isLoading,
    @JsonKey(includeToJson: false)
    @Default(false) final bool? hasError,
  }) = _PhotoModel;
  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
  
}
