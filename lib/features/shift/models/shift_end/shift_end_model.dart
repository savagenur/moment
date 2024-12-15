import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/end_report/end_report_model.dart';

part 'shift_end_model.freezed.dart';
part 'shift_end_model.g.dart';

abstract class BaseShiftEndModel {
  String? get id;
  String? get shiftId;
  DateTime? get createdAt;
  DateTime? get updatedAt;
}

@freezed
class ShiftEndModel with _$ShiftEndModel {
  const ShiftEndModel._();
  @Implements<BaseShiftEndModel>()
  const factory ShiftEndModel.snapper({
    final String? id,
    final String? shiftId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final PhotoModel? endWorkPlacePhoto,
    final PhotoModel? endCameraPhoto,
    final PhotoModel? endLaptopPhoto,
    final PhotoModel? endWiresPhoto,
    final PhotoModel? endLockPhoto,
    final PhotoModel? endBoxesPhoto,
    final PhotoModel? endPrintsPhoto,
    final PhotoModel? endGoogleDrivePhoto,
    required final SnapperEndReport endReport,
  }) = SnapperShiftEnd;

  @Implements<BaseShiftEndModel>()
  const factory ShiftEndModel.assistant({
    final String? id,
    final String? shiftId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = AssistantShiftEnd;
  factory ShiftEndModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftEndModelFromJson(
        json,
      );

  bool get isCompleted {
    return when(
      snapper: (id,
          shiftId,
          createdAt,
          updatedAt,
          endWorkPlacePhoto,
          endCameraPhoto,
          endLaptopPhoto,
          endWiresPhoto,
          endLockPhoto,
          endBoxesPhoto,
          endPrintsPhoto,
          endGoogleDrivePhoto,
          endReport) {
        return endWorkPlacePhoto != null &&
            endCameraPhoto != null &&
            endLaptopPhoto != null &&
            endWiresPhoto != null &&
            endLockPhoto != null &&
            endBoxesPhoto != null &&
            endPrintsPhoto != null &&
            endGoogleDrivePhoto != null &&
            endReport.startTime != null &&
            endReport.endTime != null &&
            endReport.soldFrameCash != null &&
            endReport.soldFrameCard != null &&
            endReport.endFrames != null &&
            endReport.endBrokenFrames != null &&
            endReport.endPaperSets != null &&
            endReport.endBrokenPaperSets != null &&
            endReport.endPrints != null;
      },
      assistant: (id, shiftId, createdAt, updatedAt) {
        return false;
      },
    );
  }

  PhotoModel? getPhoto(
    PhotoType photoType,
  ) {
    if (this is SnapperShiftEnd) {
      final snapperShiftEnd = this as SnapperShiftEnd;
      return switch (photoType) {
        PhotoType.endWorkPlace => snapperShiftEnd.endWorkPlacePhoto,
        PhotoType.endCamera => snapperShiftEnd.endCameraPhoto,
        PhotoType.endLaptop => snapperShiftEnd.endLaptopPhoto,
        PhotoType.endWires => snapperShiftEnd.endWiresPhoto,
        PhotoType.endLock => snapperShiftEnd.endLockPhoto,
        PhotoType.endBoxes => snapperShiftEnd.endBoxesPhoto,
        PhotoType.endPrints => snapperShiftEnd.endPrintsPhoto,
        PhotoType.endGoogleDrive => snapperShiftEnd.endGoogleDrivePhoto,
        _ => null,
      };
    }
    throw ArgumentError('Unsupported type: $runtimeType');
  }

  SnapperShiftEnd? updateShiftEndPhoto(
    PhotoType photoType, {
    required PhotoModel newPhoto,
  }) {
    if (this is SnapperShiftEnd) {
      final snapperShiftEnd = this as SnapperShiftEnd;
      return switch (photoType) {
        PhotoType.endWorkPlace =>
          snapperShiftEnd.copyWith(endWorkPlacePhoto: newPhoto),
        PhotoType.endCamera =>
          snapperShiftEnd.copyWith(endCameraPhoto: newPhoto),
        PhotoType.endLaptop =>
          snapperShiftEnd.copyWith(endLaptopPhoto: newPhoto),
        PhotoType.endBoxes => snapperShiftEnd.copyWith(endBoxesPhoto: newPhoto),
        PhotoType.endLock => snapperShiftEnd.copyWith(endLockPhoto: newPhoto),
        PhotoType.endWires => snapperShiftEnd.copyWith(endWiresPhoto: newPhoto),
        PhotoType.endGoogleDrive =>
          snapperShiftEnd.copyWith(endGoogleDrivePhoto: newPhoto),
        PhotoType.endPrints =>
          snapperShiftEnd.copyWith(endPrintsPhoto: newPhoto),
        _ => null,
      };
    }
    throw ArgumentError('Unsupported type: $runtimeType');
  }
}
