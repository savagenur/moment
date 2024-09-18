import 'dart:async';
import 'dart:io';

import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/shift_start/shift_start_model.dart';
import 'package:moment/features/shift/repos/snapper_shift_repo.dart';
import 'package:moment/features/shift/view_models/snapper/state/snapper_shift_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snapper_shift_viewmodel.g.dart';

@riverpod
class SnapperShiftViewModel extends _$SnapperShiftViewModel {
  final SnapperShiftRepo _shiftRepo = sl<SnapperShiftRepo>();

  @override
  SnapperShiftState build() {
    getLocalShift();
    // Start listening to shifts when the ViewModel is initialized
    final inactiveShifts = onInactiveShiftListener();
    final activeShifts = onActiveShiftListener();
    ref.onDispose(() {
      activeShifts.cancel();
      inactiveShifts.cancel();
    });
    return SnapperShiftState();
  }

  StreamSubscription<List<ShiftModel>> onActiveShiftListener() {
    final activeShiftsStream = _shiftRepo.getSnapperShiftList(status: 1);

    return activeShiftsStream.listen((activeShifts) {
      state = state.copyWith(activeShifts: AsyncValue.data(activeShifts));

      // print(state.value?.inactiveShifts);
    }, onError: (e, stackTrace) {
      state = state.copyWith(
        activeShifts: AsyncValue.error(e, stackTrace),
      );
    });
  }

  StreamSubscription<List<SnapperShift>> onInactiveShiftListener() {
    final inactiveShiftStream = _shiftRepo.getSnapperShiftList(status: 0);
    return inactiveShiftStream.listen((inactiveShifts) {
      state = state.copyWith(inactiveShifts: AsyncValue.data(inactiveShifts));

      // print(state.value?.inactiveShifts);
    }, onError: (e, stackTrace) {
      state = state.copyWith(
        inactiveShifts: AsyncValue.error(e, stackTrace),
      );
    });
  }

  Future<void> setLocalShift(SnapperShift shift) async {
    try {
      await _shiftRepo.setLocalShift(shift);
      state = state.copyWith(shiftLocal: AsyncValue.data(shift));
    } catch (e) {
      print(e);
      state =
          state.copyWith(shiftLocal: AsyncValue.error(e, StackTrace.current));
    }
  }

  /// Method to get the local shift from local storage
  Future<void> getLocalShift() async {
    try {
      final shiftLocal = await _shiftRepo.getLocalShift();
      if (shiftLocal != null) {
        state = state.copyWith(shiftLocal: AsyncValue.data(shiftLocal));
      }
    } catch (e) {
      state =
          state.copyWith(shiftLocal: AsyncValue.error(e, StackTrace.current));
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
    required SnapperShift shift,
    required PhotoModel photo,
    required bool isVideo,
    required String shiftId,
    required SnapperShiftPhotoType snapperShiftPhotoType,
  }) async {
    try {
      final imageUrl = await _shiftRepo.uploadMedia(
        file,
        isVideo: isVideo,
        shiftId: shiftId,
        snapperShiftPhotoType: snapperShiftPhotoType,
      );
      state = state.copyWith(
        shiftLocal: AsyncData(
          shift.copyWith(
            shiftStart: shift.shiftStart.updateShiftStartPhoto(
              snapperShiftPhotoType,
              newPhoto: photo,
            )!,
          ),
        ),
      );
    } catch (e) {
      logger.e(e);
    }
  }
}
