import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/core/converters/file_json_converter.dart';

part 'photo_model.g.dart';
part 'photo_model.freezed.dart';

@freezed
class PhotoModel with _$PhotoModel {
  const factory PhotoModel({
    required final String? id,
    required final String? shiftId,
    final String? userId,
    final String? userName,
    final String? restaurantName,
    final bool? isStartShift,
    required final DateTime? createdAt,
    @FileJsonConverter() final File? file,
    final String? imageUrl,
    @Default(false) final bool? isLoading,
    @Default(false) final bool? hasError,
  }) = _PhotoModel;
  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
  static PhotoModel? forFirestore(PhotoModel? photo) {
    return photo?.copyWith(
      file: null,
      isLoading: null,
      hasError: null,
    );
  }
}
