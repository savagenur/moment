import 'package:async/async.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/shift/models/shift_status_list/shift_status_list.dart';
import 'package:moment/features/shift/repos/shift_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snapper_shift_viewmodel.g.dart';

@riverpod
class SnapperShiftViewModel extends _$SnapperShiftViewModel {
  final ShiftRepo _shiftRepo = sl<ShiftRepo>();

  @override
  AsyncValue<ShiftStatusList> build() {
    return const AsyncValue.loading();
  }

  void onSnapperShiftListening() {
    final activeStream = _shiftRepo.getSnapperShiftList(status: 1);
    final inactiveStream = _shiftRepo.getSnapperShiftList(status: 0);
    // Combine both streams into one Map for easier access
    StreamZip([activeStream, inactiveStream]).listen(
      (results) {
        final activeShifts = results[0];
        final inactiveShifts = results[1];
        state = AsyncValue.data(ShiftStatusList(activeShifts, inactiveShifts));
      },
      onError: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
    );
  }
}
