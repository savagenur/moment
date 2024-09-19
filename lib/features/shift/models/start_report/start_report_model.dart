import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';

part 'start_report_model.freezed.dart';
part 'start_report_model.g.dart';

abstract class BaseStartReportModel {
  String? get id;
  String? get shiftId;
  DateTime? get date;
  DateTime? get createdAt;
  DateTime? get updatedAt;
}

@freezed
class StartReportModel with _$StartReportModel {
  @Implements<BaseStartReportModel>()
  const factory StartReportModel.snapper({
    final String? id,
    final String? shiftId,
    final DateTime? date,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final int? startFrames,
    final int? startBrokenFrames,
    final int? startPaperSets,
    final int? startBrokenPaperSets,
    final int? startPrints,
  }) = SnapperStartReport;

  @Implements<BaseStartReportModel>()
  const factory StartReportModel.assistant({
    final String? id,
    final String? shiftId,
    final DateTime? date,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = AssistantStartReport;
  factory StartReportModel.fromJson(Map<String, dynamic> json) =>
      _$StartReportModelFromJson(
        json,
      );
}
