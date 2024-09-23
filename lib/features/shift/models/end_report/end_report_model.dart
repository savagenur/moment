import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

part 'end_report_model.freezed.dart';
part 'end_report_model.g.dart';

abstract class BaseEndReportModel {
  String? get id;
  String? get shiftId;
  DateTime? get date;
  DateTime? get createdAt;
  DateTime? get updatedAt;
}

@freezed
class EndReportModel with _$EndReportModel {
  const EndReportModel._();
  @Implements<BaseEndReportModel>()
  const factory EndReportModel.snapper({
    final String? id,
    final String? shiftId,
    final DateTime? date,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    required final double hourPrice,
    required final double framePrice,
    final double? salarySupplement,
    final DateTime? startTime,
    final DateTime? endTime,
    final int? lostFrame,
    final double? taxiPrice,
    final double? other,
    final int? soldFrameCash,
    final int? soldFrameCard,
    final int? paperSetSupply,
    final int? endFrames,
    final int? endBrokenFrames,
    final int? endPaperSets,
    final int? endBrokenPaperSets,
    final int? endPrints,
    @Default([]) final List<AssistantShift> assistants,
    @Default(false) final bool isBusinessTrip,
    @Default(false) final bool isAssistantWorkedLess50,
  }) = SnapperEndReport;
  @Implements<BaseEndReportModel>()
  const factory EndReportModel.assistant({
    final String? id,
    final String? shiftId,
    final DateTime? date,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = AssistantEndReport;
  factory EndReportModel.fromJson(Map<String, dynamic> json) =>
      _$EndReportModelFromJson(
        json,
      );
  double get salary {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        final biggerSalary =
            salaryPerFrame > salaryPerHour ? salaryPerFrame : salaryPerHour;
        return biggerSalary;
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) {
        throw Exception("Unsupported type: $runtimeType");
      },
    );
  }

  double get salaryPerHour {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        final workDuration = endTime != null && startTime != null
            ? endTime.difference(startTime)
            : const Duration();
        final salaryPerHour = (workDuration.inMinutes / 60) * hourPrice;
        return salaryPerHour;
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) {
        throw Exception("Unsupported type: $runtimeType");
      },
    );
  }

  double get totalCash {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        return (soldFrameCash ?? 0 * framePrice).toDouble();
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) {
        throw Exception("Unsupported type: $runtimeType");
      },
    );
  }

  double get totalCard {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        return (soldFrameCard ?? 0 * framePrice).toDouble();
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) {
        throw Exception("Unsupported type: $runtimeType");
      },
    );
  }

  double get salaryPerFrame {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        final salaryPerFrame = ((soldFrameCash ?? 0) + (soldFrameCard ?? 0)) *
            salaryFrameCoefficient;
        return salaryPerFrame;
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) {
        throw Exception("Unsupported type: $runtimeType");
      },
    );
  }

  double get salaryFrameCoefficient {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        final coefficient = isAssistantWorkedLess50 &&
                    assistants.isNotEmpty &&
                    totalSoldFrame >= 40 ||
                assistants.isEmpty && totalSoldFrame >= 40
            ? 5
            : 4;
        return coefficient.toDouble();
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) {
        throw Exception("Unsupported type: $runtimeType");
      },
    );
  }

  double get managerCash {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        double assistantSalary = 0;
        for (var assistant in assistants) {
          // assistantSalary+=assistant.salary??0;
          // assistantSalary+=assistant.taxiPrice??0;
          assistantSalary += 0;
          assistantSalary += 0;
        }
        return (soldFrameCash ?? 0) - assistantSalary;
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) =>
          throw Exception("Unsupported type: $runtimeType"),
    );
  }

  int get totalSoldFrame {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        return (soldFrameCash ?? 0) + (soldFrameCard ?? 0);
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) =>
          throw Exception("Unsupported type: $runtimeType"),
    );
  }

  int get printedPaperAmount {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        return (soldFrameCash ?? 0) + (soldFrameCard ?? 0);
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) {
        throw Exception("Unsupported type: $runtimeType");
      },
    );
  }

  int startEndFrameDifference(int? startFrames) {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        return (endFrames ?? 0) - (startFrames ?? 0);
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) =>
          throw Exception("Unsupported type: $runtimeType"),
    );
  }

  int get soldRemainFrameDifference {
    return when(
      snapper: (id,
          shiftId,
          date,
          createdAt,
          updatedAt,
          hourPrice,
          framePrice,
          salarySupplement,
          startTime,
          endTime,
          lostFrame,
          taxiPrice,
          other,
          soldFrameCash,
          soldFrameCard,
          paperSetSupply,
          endFrames,
          endBrokenFrames,
          endPaperSets,
          endBrokenPaperSets,
          endPrints,
          assistants,
          isBusinessTrip,
          isAssistantWorkedLess50) {
        return totalSoldFrame - (endFrames ?? 0);
      },
      assistant: (id, shiftId, date, createdAt, updatedAt) =>
          throw Exception("Unsupported type: $runtimeType"),
    );
  }
}
