import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/features/shift/models/snapper_start_report/snapper_start_report_model.dart';

part 'shift_model.freezed.dart';
part 'shift_model.g.dart';

abstract class BaseShiftModel {
  String? get id;
  String? get userId;
  String? get restaurantId;
  String? get userFullName;
  String? get userRole;
}

@freezed
sealed class ShiftModel with _$ShiftModel {
  @Implements<BaseShiftModel>()
  const factory ShiftModel.manager({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
  }) = ManagerShift;

  @Implements<BaseShiftModel>()
  const factory ShiftModel.assistant({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    final StartReportModel? startReportModel,
  }) = AssistantShift;
  @Implements<BaseShiftModel>()
  const factory ShiftModel.owner({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
  }) = OwnerShift;
  @Implements<BaseShiftModel>()
  const factory ShiftModel.snapper({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    final List<String>? assistants,
    final String? restaurantName,
    final DateTime? startTime,
    final DateTime? endTime,
    final int? status,
    final int? photosSoldCard,
    final int? photosSoldCash,
    final StartReportModel? startReportModel,
    final String? clothesImageUrl,
    final String? startWorkPlaceImageUrl,
    final String? startCameraImageUrl,
    final String? startLaptopImageUrl,
    final String? startWiresImageUrl,
  }) = SnapperShift;

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(
        json,
      );
}

