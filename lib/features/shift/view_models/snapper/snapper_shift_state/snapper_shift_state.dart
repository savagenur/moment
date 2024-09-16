// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
part 'snapper_shift_state.freezed.dart';

@freezed
class SnapperShiftState with _$SnapperShiftState {
  const factory SnapperShiftState({
    @Default([]) final List<SnapperShift> activeShifts,
    @Default([]) final List<SnapperShift> inactiveShifts,
    final ShiftModel? shiftLocal,
  }) = _SnapperShiftState;
}
