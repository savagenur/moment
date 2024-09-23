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
import 'package:queue/queue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snapper_shift_viewmodel.g.dart';

@riverpod
class SnapperShiftViewModel extends _$SnapperShiftViewModel {
  final SnapperShiftRepo _shiftRepo = sl<SnapperShiftRepo>();
  final _queue = Queue(delay: const Duration(milliseconds: 10));

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
    bool isVideo = false,
  }) async {
    return await _queue.add(() async {
      // Attempt to prepare the shift for media upload
      final shift = _prepareShiftForUpload(newPhoto);
      if (shift == null) {
        return _shiftIsNullFailure();
      }

      // Early exit if another upload is already in progress
      if (newPhoto.isLoading ?? false) {
        return _uploadInProgressFailure();
      }

      // Mark the photo as loading and update the shift state
      _setShiftLoading(shift, newPhoto);

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
        (imageUrl) async => await _handleSuccessfulUpload(
          shift,
          newPhoto,
          imageUrl,
        ),
      );
    });
  }

// Helper function to prepare the shift for upload
  SnapperShift? _prepareShiftForUpload(PhotoModel newPhoto) {
    final oldShift = state.shift?.value;
    if (oldShift == null) return null;

    return oldShift.copyWith(
      updatedAt: DateTime.now(),
      shiftStart: oldShift.shiftStart
          .updateShiftStartPhoto(
            newPhoto.photoType,
            newPhoto: newPhoto,
          )!
          .copyWith(
            updatedAt: DateTime.now(),
          ),
    );
  }

// Handles the scenario where shift is null
  Either<AppFailure, Unit> _shiftIsNullFailure() {
    logger.e("Shift is null; cannot upload media.");
    return Left(AppFailure("Shift is null; cannot upload media."));
  }

// Handles the scenario where another upload is already in progress
  Either<AppFailure, Unit> _uploadInProgressFailure() {
    logger.e("Upload already in progress for this photo type.");
    return Left(AppFailure("Upload already in progress for this photo type."));
  }

// Sets the shift as loading before the upload starts
  void _setShiftLoading(SnapperShift shift, PhotoModel newPhoto) {
    final updatedShift = shift.copyWith(
      shiftStart: shift.shiftStart.updateShiftStartPhoto(
        newPhoto.photoType,
        newPhoto: newPhoto.copyWith(
          isLoading: true,
          hasError: false,
        ),
      )!,
    );
    setShift(updatedShift);
  }

// Handles the successful upload scenario
  Future<Either<AppFailure, Unit>> _handleSuccessfulUpload(
    SnapperShift shift,
    PhotoModel newPhoto,
    String? imageUrl,
  ) async {
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
      (failure) => _handleUploadMediaError(failure.message, shift, newPhoto),
      (_) {
        setShift(updatedShift);
        return const Right(unit);
      },
    );
  }

  Left<AppFailure, Unit> _handleUploadMediaError(
    String e,
    SnapperShift? shift,
    PhotoModel newPhoto,
  ) {
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
