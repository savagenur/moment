import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift_end/shift_end_model.dart';
import 'package:moment/features/shift/models/shift_start/shift_start_model.dart';

part 'shift_model.freezed.dart';
part 'shift_model.g.dart';

abstract class BaseShiftModel {
  String? get id;
  String? get userId;
  String? get restaurantId;
  String? get userFullName;
  String? get userRole;
  DateTime? get createdAt;
  DateTime? get updatedAt;
}

@freezed
sealed class ShiftModel with _$ShiftModel {
  const ShiftModel._();
  @Implements<BaseShiftModel>()
  const factory ShiftModel.manager({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    required final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = ManagerShift;

  @Implements<BaseShiftModel>()
  const factory ShiftModel.assistant({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    required final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = AssistantShift;
  @Implements<BaseShiftModel>()
  const factory ShiftModel.owner({
    final String? id,
    final String? userId,
    final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    required final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = OwnerShift;
  @Implements<BaseShiftModel>()
  const factory ShiftModel.snapper({
    required final String? id,
    final String? userId,
    required final String? restaurantId,
    final String? userFullName,
    final String? userRole,
    required final DateTime? createdAt,
    final DateTime? updatedAt,
    final List<String>? assistants,
    required final String? restaurantName,
    required final DateTime? startTime,
    final DateTime? endTime,
    required final int? status,
    @Default(SnapperShiftStart()) final SnapperShiftStart shiftStart,
    required final SnapperShiftEnd shiftEnd,
  }) = SnapperShift;

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(
        json,
      );
 
}
