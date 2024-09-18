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
import 'package:moment/features/shift/models/snapper_start_report/snapper_start_report_model.dart';
import 'package:moment/features/shift/view_models/snapper/snapper_shift_viewmodel.dart';
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
    final shiftViewModel = ref.watch(snapperShiftViewModelProvider).value;
    final shiftViewModelNotifier =
        ref.read(snapperShiftViewModelProvider.notifier);
    final snapperShiftLocal = shiftViewModel?.shiftLocal as SnapperShift?;
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
              shiftPhotoType: SnapperShiftPhotoType.clothes,
              index: "1",
              title: "Clothes Photo",
              shift: shiftLatest,
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: SnapperShiftPhotoType.clothes,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: SnapperShiftPhotoType.startWorkPlace,
              index: "2",
              shift: shiftLatest,
              title: "Workplace Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: SnapperShiftPhotoType.startWorkPlace,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: SnapperShiftPhotoType.startCamera,
              index: "3",
              shift: shiftLatest,
              title: "Camera Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: SnapperShiftPhotoType.startCamera,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: SnapperShiftPhotoType.startLaptop,
              index: "4",
              shift: shiftLatest,
              title: "Laptop Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: SnapperShiftPhotoType.startLaptop,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: SnapperShiftPhotoType.startWires,
              index: "5",
              shift: shiftLatest,
              title: "Wires Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shiftComparator,
                        photoType: SnapperShiftPhotoType.startWires,
                      ),
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            Divider(),
            SnapperShiftDetailItem(
              shiftPhotoType: SnapperShiftPhotoType.none,
              index: "6",
              title: "Shift start report",
              onTap: () => context.pushRoute(SnapperShiftStartReportRoute(
                snapperShift: shiftLatest!,
              )),
              trailing: _isStartReportCompleted(
                      (shiftLatest?.startReportModel as SnapperStartReport?))
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
          onTap: () {
            if (_isSubmitValid(shiftLatest!)) {
              // shiftViewModelNotifier.updateShift(
              //   shiftLatest.copyWith(
              //     status: 0,
              //   ),
              // );
              Fluttertoast.showToast(msg: "Successfully saved");
            } else {
              if (!_isStartReportCompleted(shiftLatest.startReportModel)) {
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
          },
        ),
      ),
    );
  }

  bool _isStartReportCompleted(SnapperStartReport? startReportModel) =>
      startReportModel?.startFrames != null &&
      startReportModel?.startBrokenFrames != null &&
      startReportModel?.startPaperSets != null &&
      startReportModel?.startBrokenPaperSets != null &&
      startReportModel?.startPrints != null;
  bool _isSubmitValid(SnapperShift shift) {
    return _isStartReportCompleted(shift.startReportModel) &&
        shift.startReportModel?.clothesPhoto != null &&
        shift.startReportModel?.startWorkPlacePhoto != null &&
        shift.startReportModel?.startCameraPhoto != null &&
        shift.startReportModel?.startLaptopPhoto != null &&
        shift.startReportModel?.startWiresPhoto != null;
  }

  void _addPhoto(
    SnapperShiftViewModel shiftViewModelNotifier,
    SnapperShiftComparator shiftComparator, {
    required SnapperShiftPhotoType photoType,
  }) async {
    final photoFile = await PhotoRepo.takePhoto(ImageSource.camera);
    if (photoFile != null) {
      final shiftLatest = shiftComparator.getLatestShift();

      PhotoModel? newPhoto = getPhotoModel(shiftLatest, photoFile);

      final updatedShift =
          photoType.updateShiftWithPhoto(shiftLatest, newPhoto)?.copyWith(
                createdAt: DateTime.now(),
              );

      if (updatedShift != null) {
        shiftViewModelNotifier.setLocalShift(updatedShift);
      }
    }
  }

  PhotoModel? getPhotoModel(
    SnapperShift? shiftLatest,
    File? photoFile,
  ) {
    return PhotoModel(
      id: const Uuid().v1(),
      file: photoFile,
      createdAt: DateTime.now(),
      restaurantName: shiftLatest?.restaurantName,
      shiftId: shiftLatest?.id,
    );
  }
}
