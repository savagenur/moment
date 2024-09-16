import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/snapper_start_report/snapper_start_report_model.dart';

part 'shift_model.freezed.dart';
part 'shift_model.g.dart';

abstract class BaseShiftModel {
  String? get id;
  String? get userId;
  String? get restaurantId;
  String? get userFullName;
  String? get userRole;
  DateTime? get createdAt;
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
    required final DateTime? createdAt,
  }) = ManagerShift;

  @Implements<BaseShiftModel>()
  const factory ShiftModel.assistant({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    required final DateTime? createdAt,
    final StartReportModel? startReportModel,
  }) = AssistantShift;
  @Implements<BaseShiftModel>()
  const factory ShiftModel.owner({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    required final DateTime? createdAt,
  }) = OwnerShift;
  @Implements<BaseShiftModel>()
  const factory ShiftModel.snapper({
    required final String? id,
    final String? userId,
    required final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    required final DateTime? createdAt,
    final List<String>? assistants,
    required final String? restaurantName,
    required final DateTime? startTime,
    final DateTime? endTime,
    required final int? status,
    final SnapperStartReport? startReportModel,
  }) = SnapperShift;

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(
        json,
      );

}
