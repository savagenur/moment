import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/start_report/start_report_model.dart';

part 'shift_start_model.freezed.dart';
part 'shift_start_model.g.dart';

abstract class BaseShiftStartModel {
  String? get id;
  String? get shiftId;
  DateTime? get createdAt;
}

@freezed
class ShiftStartModel with _$ShiftStartModel {
  // ignore: unused_element
  const ShiftStartModel._();
  @Implements<BaseShiftStartModel>()
  const factory ShiftStartModel.snapper({
    final String? id,
    final String? shiftId,
    final DateTime? createdAt,
    final PhotoModel? clothesPhoto,
    final PhotoModel? startWorkPlacePhoto,
    final PhotoModel? startCameraPhoto,
    final PhotoModel? startLaptopPhoto,
    final PhotoModel? startWiresPhoto,
    @Default(SnapperStartReport()) final SnapperStartReport startReport,
  }) = SnapperShiftStart;

  @Implements<BaseShiftStartModel>()
  const factory ShiftStartModel.assistant({
    final String? id,
    final String? shiftId,
    final DateTime? createdAt,
  }) = AssistantShiftStart;
  factory ShiftStartModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftStartModelFromJson(
        json,
      );
  T forFirestore<T>() {
    if (this is SnapperShiftStart) {
      final shiftStart = this as SnapperShiftStart;
      return shiftStart.copyWith(
        clothesPhoto: shiftStart.clothesPhoto,
        startWorkPlacePhoto: shiftStart.startWorkPlacePhoto,
        startCameraPhoto: shiftStart.startCameraPhoto,
        startLaptopPhoto: shiftStart.startLaptopPhoto,
        startWiresPhoto: shiftStart.startWiresPhoto,
      ) as T;
    } else {
      throw ArgumentError('Unsupported type: $runtimeType');
    }
  }

  // Map<String, dynamic> toSqlJson() {
  //   final data = toJson();
  //   if (this is SnapperShiftStart) {
  //     final shiftStart = this as SnapperShiftStart;
  //     data.addEntries([
  //       MapEntry("clothesPhoto", shiftStart.clothesPhoto),
  //       MapEntry("startWorkPlacePhoto", shiftStart.startWorkPlacePhoto),
  //       MapEntry("startCameraPhoto", shiftStart.startCameraPhoto),
  //       MapEntry("startLaptopPhoto", shiftStart.startLaptopPhoto),
  //       MapEntry("startWiresPhoto", shiftStart.startWiresPhoto),
  //     ]);
  //     return data;
  //   } else {
  //     throw ArgumentError('Unsupported type: $runtimeType');
  //   }
  // }

  PhotoModel? getPhoto(
    SnapperShiftPhotoType photoType,
  ) {
    if (this is SnapperShiftStart) {
      final snapperShiftStart = this as SnapperShiftStart;
      return switch (photoType) {
        SnapperShiftPhotoType.clothes => snapperShiftStart.clothesPhoto,
        SnapperShiftPhotoType.startWorkPlace =>
          snapperShiftStart.startWorkPlacePhoto,
        SnapperShiftPhotoType.startCamera => snapperShiftStart.startCameraPhoto,
        SnapperShiftPhotoType.startLaptop => snapperShiftStart.startLaptopPhoto,
        SnapperShiftPhotoType.startWires => snapperShiftStart.startWiresPhoto,
        SnapperShiftPhotoType.none => null,
      };
    }
    throw ArgumentError('Unsupported type: $runtimeType');
  }

  SnapperShiftStart? updateShiftStartPhoto(
    SnapperShiftPhotoType photoType, {
    required PhotoModel newPhoto,
  }) {
    if (this is SnapperShiftStart) {
      final snapperShiftStart = this as SnapperShiftStart;
      return switch (photoType) {
        SnapperShiftPhotoType.clothes =>
          snapperShiftStart.copyWith(clothesPhoto: newPhoto),
        SnapperShiftPhotoType.startWorkPlace =>
          snapperShiftStart.copyWith(startWorkPlacePhoto: newPhoto),
        SnapperShiftPhotoType.startCamera =>
          snapperShiftStart.copyWith(startCameraPhoto: newPhoto),
        SnapperShiftPhotoType.startLaptop =>
          snapperShiftStart.copyWith(startLaptopPhoto: newPhoto),
        SnapperShiftPhotoType.startWires =>
          snapperShiftStart.copyWith(startWiresPhoto: newPhoto),
        SnapperShiftPhotoType.none => null,
      };
    }
    throw ArgumentError('Unsupported type: $runtimeType');
  }
}
