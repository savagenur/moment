import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/utils/utils.dart';
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

  void setShift(SnapperShift? shift) async {
    state = state.copyWith(shift: AsyncValue.data(shift));
  }

  /// Method to get the local shift from local storage
  Future<void> getShift(String id) async {
    try {
      final shift = await _shiftRepo.getShift(id);
      if (shift != null) {
        setShift(shift);
      }
    } catch (e) {
      state = state.copyWith(shift: AsyncValue.error(e, StackTrace.current));
    }
  }

  Future<void> updateShift(SnapperShift? shift) async {
    try {
      await _shiftRepo.updateShift(shift);
      setShift(shift);
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }
  }

  Future<void> uploadMedia(
    File file, {
    required PhotoModel newPhoto,
    required SnapperShift? shift,
    required bool isVideo,
  }) async {
    try {
      setShift(shift?.copyWith(
        shiftStart: shift.shiftStart.updateShiftStartPhoto(
          newPhoto.photoType,
          newPhoto: newPhoto.copyWith(
            isLoading: true,
            hasError: false,
          ),
        )!,
      ));
      final imageUrl = await _shiftRepo.uploadMedia(
        file,
        isVideo: isVideo,
        shiftId: newPhoto.shiftId!,
        snapperShiftPhotoType: newPhoto.photoType,
      );
      final updatedShift = shift?.copyWith(
        shiftStart: shift.shiftStart.updateShiftStartPhoto(
          newPhoto.photoType,
          newPhoto: newPhoto.copyWith(
            imageUrl: imageUrl,
            isLoading: false,
            hasError: false,
          ),
        )!,
      );
      await _shiftRepo.updateShift(updatedShift);
    } catch (e) {
      setShift(shift?.copyWith(
        shiftStart: shift.shiftStart.updateShiftStartPhoto(
          newPhoto.photoType,
          newPhoto: newPhoto.copyWith(
            isLoading: false,
            hasError: true,
          ),
        )!,
      ));
      logger.e(e);
    }
  }
}
