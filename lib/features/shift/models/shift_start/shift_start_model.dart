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
  DateTime? get updatedAt;
}

@freezed
class ShiftStartModel with _$ShiftStartModel {
  const ShiftStartModel._();
  @Implements<BaseShiftStartModel>()
  const factory ShiftStartModel.snapper({
    final String? id,
    final String? shiftId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
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
    final DateTime? updatedAt,
  }) = AssistantShiftStart;
  factory ShiftStartModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftStartModelFromJson(
        json,
      );

  bool get isCompleted {
    return when(
      snapper: (id,
          shiftId,
          createdAt,
          updatedAt,
          clothesPhoto,
          startWorkPlacePhoto,
          startCameraPhoto,
          startLaptopPhoto,
          startWiresPhoto,
          startReport) {
        return clothesPhoto != null &&
            startWorkPlacePhoto != null &&
            startCameraPhoto != null &&
            startLaptopPhoto != null &&
            startWiresPhoto != null &&
            startReport.startFrames != null &&
            startReport.startBrokenFrames != null &&
            startReport.startPaperSets != null &&
            startReport.startBrokenPaperSets != null &&
            startReport.startPrints != null;
      },
      assistant: (id, shiftId, createdAt, updatedAt) {
        return false;
      },
    );
  }

  PhotoModel? getPhoto(
    PhotoType photoType,
  ) {
    if (this is SnapperShiftStart) {
      final snapperShiftStart = this as SnapperShiftStart;
      return switch (photoType) {
        PhotoType.clothes => snapperShiftStart.clothesPhoto,
        PhotoType.startWorkPlace => snapperShiftStart.startWorkPlacePhoto,
        PhotoType.startCamera => snapperShiftStart.startCameraPhoto,
        PhotoType.startLaptop => snapperShiftStart.startLaptopPhoto,
        PhotoType.startWires => snapperShiftStart.startWiresPhoto,
        _ => null,
      };
    }
    throw ArgumentError('Unsupported type: $runtimeType');
  }

  SnapperShiftStart? updateShiftStartPhoto(
    PhotoType photoType, {
    required PhotoModel newPhoto,
  }) {
    if (this is SnapperShiftStart) {
      final snapperShiftStart = this as SnapperShiftStart;
      return switch (photoType) {
        PhotoType.clothes => snapperShiftStart.copyWith(clothesPhoto: newPhoto),
        PhotoType.startWorkPlace =>
          snapperShiftStart.copyWith(startWorkPlacePhoto: newPhoto),
        PhotoType.startCamera =>
          snapperShiftStart.copyWith(startCameraPhoto: newPhoto),
        PhotoType.startLaptop =>
          snapperShiftStart.copyWith(startLaptopPhoto: newPhoto),
        PhotoType.startWires =>
          snapperShiftStart.copyWith(startWiresPhoto: newPhoto),
        _ => null,
      };
    }
    throw ArgumentError('Unsupported type: $runtimeType');
  }
}
