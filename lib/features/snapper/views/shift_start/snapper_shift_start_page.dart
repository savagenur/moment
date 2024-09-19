// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/app/widgets/primary_button.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/photo/repos/photo_repo.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/shift_start/shift_start_model.dart';
import 'package:moment/features/shift/models/start_report/start_report_model.dart';
import 'package:moment/features/shift/view_models/snapper/bloc/snapper_shift_viewmodel.dart';
import 'package:moment/features/snapper/models/snapper_shift_comparator.dart';
import 'package:moment/features/snapper/views/widgets/snapper_shift_detail_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class SnapperShiftStartPage extends HookConsumerWidget {
  final ShiftModel shiftRemote;
  const SnapperShiftStartPage({
    super.key,
    required this.shiftRemote,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftViewModel = ref.watch(snapperShiftViewModelProvider);
    final shiftViewModelNotifier =
        ref.read(snapperShiftViewModelProvider.notifier);
    final snapperShiftLocal = shiftViewModel.shiftLocal?.value;
    final snapperShiftRemote = shiftRemote as SnapperShift;
    final shiftComparator = SnapperShiftComparator(
      local: snapperShiftLocal,
      remote: snapperShiftRemote,
    );
    final shiftLatest = shiftComparator.getLatestShift();

    return Scaffold(
      appBar: AppBar(
        title: Text("Shift start"),
        actions: [
          ElevatedButton(
              onPressed: () async {
                final Database db = await openDatabase('app.db');

                // Execute a query to get all the data from a specific table (e.g., 'items')
                List<Map<String, dynamic>> result = await db.query('shift');

                // Print or inspect the content
                result.forEach((row) {
                  log(row.toString());
                });
              },
              child: Text("press"))
        ],
      ),
      body: SingleChildScrollView(
        padding: DDimension.mediumPadding.all,
        child: Column(
          children: [
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.clothes,
              index: "1",
              title: "Clothes Photo",
              shift: shiftLatest,
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: PhotoType.clothes,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startWorkPlace,
              index: "2",
              shift: shiftLatest,
              title: "Workplace Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: PhotoType.startWorkPlace,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startCamera,
              index: "3",
              shift: shiftLatest,
              title: "Camera Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: PhotoType.startCamera,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startLaptop,
              index: "4",
              shift: shiftLatest,
              title: "Laptop Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: PhotoType.startLaptop,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startWires,
              index: "5",
              shift: shiftLatest,
              title: "Wires Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: PhotoType.startWires,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            Divider(),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.none,
              index: "6",
              title: "Shift start report",
              onTap: () => context.pushRoute(SnapperShiftStartReportRoute(
                snapperShift: shiftLatest!,
              )),
              trailing: _isStartReportCompleted((shiftLatest?.shiftStart))
                  ? Icon(
                      Icons.checklist_rtl,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.list,
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PrimaryButton(
          title: Text("Submit"),
          margin: DDimension.bigPadding.all,
          onTap: () async {
            if (_isSubmitValid(shiftLatest!)) {
              await _handleSubmit(shiftViewModelNotifier, shiftLatest);
            } else {
              _handleInvalidSubmit(shiftLatest);
            }
          },
        ),
      ),
    );
  }

// Function to handle successful submission
  Future<void> _handleSubmit(
      SnapperShiftViewModel shiftViewModelNotifier, SnapperShift shift) async {
    try {
      await shiftViewModelNotifier.updateRemoteShift(
        shift,
      );
      Fluttertoast.showToast(
        msg: "Successfully saved",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      // Improved error message display
      Fluttertoast.showToast(
        msg: "Error occurred while saving: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Function to handle invalid submission
  void _handleInvalidSubmit(SnapperShift shift) {
    if (!_isStartReportCompleted(shift.shiftStart)) {
      Fluttertoast.showToast(
        msg: "Please complete 'Shift start report'",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Please take all photos",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  bool _isStartReportCompleted(SnapperShiftStart? shiftStart) =>
      shiftStart?.startReport.startFrames != null &&
      shiftStart?.startReport.startBrokenFrames != null &&
      shiftStart?.startReport.startPaperSets != null &&
      shiftStart?.startReport.startBrokenPaperSets != null &&
      shiftStart?.startReport.startPrints != null;
  bool _isSubmitValid(SnapperShift shift) {
    return _isStartReportCompleted(shift.shiftStart) &&
        shift.shiftStart.clothesPhoto != null &&
        shift.shiftStart.startWorkPlacePhoto != null &&
        shift.shiftStart.startCameraPhoto != null &&
        shift.shiftStart.startLaptopPhoto != null &&
        shift.shiftStart.startWiresPhoto != null;
  }

  void _addPhoto(
    SnapperShiftViewModel shiftViewModelNotifier,
    SnapperShiftComparator shiftComparator, {
    required PhotoType photoType,
  }) async {
    final file = await PhotoRepo.takePhoto(ImageSource.camera);
    if (file != null) {
      final shiftLatest = shiftComparator.getLatestShift();

      PhotoModel? newPhoto = getPhotoModel(shiftLatest, file, photoType);

      final newShift = shiftLatest?.copyWith(
        updatedAt: DateTime.now(),
        shiftStart: shiftLatest.shiftStart
            .updateShiftStartPhoto(
              photoType,
              newPhoto: newPhoto,
            )!
            .copyWith(
              updatedAt: DateTime.now(),
            ),
      );
      if (newShift != null) {
        shiftViewModelNotifier.uploadMedia(
          newPhoto,
          shift: newShift,
          isVideo: false,
        );
      }
    }
  }

  PhotoModel getPhotoModel(
    SnapperShift? shiftLatest,
    File? photoFile,
    PhotoType photoType,
  ) {
    return PhotoModel(
      id: const Uuid().v1(),
      photoType: photoType,
      file: photoFile,
      createdAt: DateTime.now(),
      restaurantName: shiftLatest?.restaurantName,
      shiftId: shiftLatest?.id,
    );
  }
}
