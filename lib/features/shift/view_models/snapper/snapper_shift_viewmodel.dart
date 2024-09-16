import 'dart:async';
import 'dart:io';

import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/repos/snapper_shift_repo.dart';
import 'package:moment/features/shift/view_models/snapper/snapper_shift_state/snapper_shift_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snapper_shift_viewmodel.g.dart';

@riverpod
class SnapperShiftViewModel extends _$SnapperShiftViewModel {
  final SnapperShiftRepo _shiftRepo = sl<SnapperShiftRepo>();

  @override
  AsyncValue<SnapperShiftState> build() {
    getLocalShift();
    // Start listening to shifts when the ViewModel is initialized
    final inactiveShifts = onInactiveShiftListener();
    final activeShifts = onActiveShiftListener();
    ref.onDispose(() {
      activeShifts.cancel();
      inactiveShifts.cancel();
    });
    return const AsyncValue.loading();
  }

  StreamSubscription<List<ShiftModel>> onActiveShiftListener() {
    final activeShiftsStream = _shiftRepo.getSnapperShiftList(status: 1);

    return activeShiftsStream.listen((activeShifts) {
      state = AsyncValue.data(state.value?.copyWith(
            activeShifts: activeShifts,
          ) ??
          SnapperShiftState(activeShifts: activeShifts));
      // print(state.value?.inactiveShifts);
    }, onError: (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    });
  }

  StreamSubscription<List<SnapperShift>> onInactiveShiftListener() {
    final inactiveShiftStream = _shiftRepo.getSnapperShiftList(status: 0);
    return inactiveShiftStream.listen((inactiveShifts) {
      state = AsyncValue.data(state.value?.copyWith(
            inactiveShifts: inactiveShifts,
          ) ??
          SnapperShiftState(inactiveShifts: inactiveShifts));
    }, onError: (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    });
  }

  Future<void> setLocalShift(SnapperShift shift) async {
    try {
      await _shiftRepo.setLocalShift(shift);
        state = AsyncValue.data(
            state.value!.copyWith(shiftLocal: shift.copyWith()));
    } catch (e) {
      print(e);
    }
  }

  /// Method to get the local shift from local storage
  Future<void> getLocalShift() async {
    try {
      final shiftLocal = await _shiftRepo.getLocalShift();
      if (shiftLocal != null) {
        state = AsyncValue.data(state.value!.copyWith(shiftLocal: shiftLocal));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateShift(SnapperShift shift) async {
    try {
      await _shiftRepo.updateShift(shift);
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadMedia(
    File file, {
    required bool isVideo,
    required String shiftId,
    required SnapperShiftPhotoType snapperShiftPhotoType,
  }) async {
    try {
      await _shiftRepo.uploadMedia(
        file,
        isVideo: isVideo,
        shiftId: shiftId,
        snapperShiftPhotoType: snapperShiftPhotoType,
      );
      state = AsyncValue.data(state.value!.copyWith(

      ));
    } catch (e) {
      logger.e(e);
    }
  }
}
