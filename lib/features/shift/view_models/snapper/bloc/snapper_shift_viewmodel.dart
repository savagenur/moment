import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:moment/core/failure/failure.dart';
import 'package:moment/core/utils/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
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
    return const SnapperShiftState();
  }

  StreamSubscription<List<ShiftModel>> onActiveShiftListener() {
    final activeShiftsStream = _shiftRepo.getSnapperShiftList(status: 1);

    return activeShiftsStream.listen((activeShifts) {
      state = state.copyWith(activeShifts: AsyncValue.data(activeShifts));
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
    }, onError: (e, stackTrace) {
      state = state.copyWith(
        inactiveShifts: AsyncValue.error(e, stackTrace),
      );
    });
  }

  void setShift(SnapperShift? shift) async {
    state = state.copyWith(shift: AsyncValue.data(shift));
  }

  Future<Either<AppFailure, Unit>> getShift(String id) async {
    final res = await _shiftRepo.getShift(id);
    return res.fold(
      (l) {
        state = state.copyWith(
            shift: AsyncValue.error(l.message, StackTrace.current));
        return Left(AppFailure(l.message));
      },
      (shift) {
        if (shift != null) {
          setShift(shift);
        }
        return const Right(unit);
      },
    );
  }

  Future<Either<AppFailure, Unit>> updateShift(SnapperShift? shift) async {
    final res = await _shiftRepo.updateShift(shift);
    return res.fold(
      (l) {
        logger.e(l.message);
        return Left(AppFailure(l.message));
      },
      (r) {
        setShift(shift);
        return const Right(unit);
      },
    );
  }

  Future<Either<AppFailure, Unit>> uploadMedia(
    File file, {
    required PhotoModel newPhoto,
    required SnapperShift? shift,
     bool isVideo = false,
  }) async {
    if (shift == null) {
      logger.e("Shift is null; cannot upload media.");
      return Left(AppFailure(
          "Shift is null; cannot upload media.")); // Early exit if shift is null
    }

    // Update state to indicate that the media is being uploaded
    setShift(
      shift.copyWith(
        shiftStart: shift.shiftStart.updateShiftStartPhoto(
          newPhoto.photoType,
          newPhoto: newPhoto.copyWith(
            isLoading: true,
            hasError: false,
          ),
        )!,
      ),
    );

    // Attempt to upload the media file
    final uploadResult = await _shiftRepo.uploadMedia(
      file,
      isVideo: isVideo,
      shiftId: newPhoto.shiftId!,
      snapperShiftPhotoType: newPhoto.photoType,
    );

    // Handle the result of the media upload
    return await uploadResult.fold(
      (failure) => _handleUploadMediaError(failure.message, shift, newPhoto),
      (imageUrl) async {
        // Create an updated shift with the new image URL
        final updatedShift = shift.copyWith(
          shiftStart: shift.shiftStart.updateShiftStartPhoto(
            newPhoto.photoType,
            newPhoto: newPhoto.copyWith(
              imageUrl: imageUrl,
              isLoading: false,
              hasError: false,
            ),
          )!,
        );

        // Attempt to update the shift with the new media details
        final updateRes = await _shiftRepo.updateShift(updatedShift);

        // Handle the result of the shift update
        return updateRes.fold(
          (failure) =>
              _handleUploadMediaError(failure.message, shift, newPhoto),
          (_) {
            setShift(updatedShift);
            return const Right(unit);
          },
        );
      },
    );
  }

  Left<AppFailure, Unit> _handleUploadMediaError(
      String e, SnapperShift? shift, PhotoModel newPhoto) {
    logger.e(e);

    setShift(shift?.copyWith(
      shiftStart: shift.shiftStart.updateShiftStartPhoto(
        newPhoto.photoType,
        newPhoto: newPhoto.copyWith(
          isLoading: false,
          hasError: true,
        ),
      )!,
    ));
    return Left(AppFailure(e));
  }
}
