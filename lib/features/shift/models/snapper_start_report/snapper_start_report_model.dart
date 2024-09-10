import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'snapper_start_report_model.freezed.dart';
part 'snapper_start_report_model.g.dart';

abstract class BaseStartReportModel {
  String? get id;
  String? get shiftId;
  String? get userId;
  String? get restaurantId;
  String? get restaurantName;
  DateTime? get date;
}

@freezed
class StartReportModel with _$StartReportModel {
  @Implements<BaseStartReportModel>()
  const factory StartReportModel.snapper({
    final String? id,
    final String? shiftId,
    final String? userId,
    final String? restaurantId,
    final String? restaurantName,
    final DateTime? date,
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
    final String? userId,
    final String? restaurantId,
    final String? restaurantName,
    final DateTime? date,
  }) = AssistantStartReport;
  factory StartReportModel.fromJson(Map<String, dynamic> json) =>
      _$StartReportModelFromJson(
        json,
      );
}
