// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/photo/repos/photo_repo.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/shift_start/shift_start_model.dart';
import 'package:moment/features/shift/view_models/snapper/bloc/snapper_shift_viewmodel.dart';
import 'package:moment/features/snapper/views/widgets/snapper_shift_detail_item.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class SnapperShiftStartPage extends HookConsumerWidget {
  final SnapperShift snapperShift;
  const SnapperShiftStartPage({
    super.key,
    required this.snapperShift,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shift = ref.watch(snapperShiftViewModelProvider).shift?.value;
    final shiftViewModelNotifier =
        ref.read(snapperShiftViewModelProvider.notifier);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          shiftViewModelNotifier.setShift(snapperShift);
        },
      );
      return null;
    }, []);

    return Scaffold(
      appBar: buildAppBar(context, shift),
      body: SingleChildScrollView(
        padding: DDimension.mediumPadding.all,
        child: Column(
          children: [
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.clothes,
              index: "1",
              title: "Clothes Photo",
              shift: shift,
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shift,
                        photoType: PhotoType.clothes,
                      ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: context.colors.primaryGreen,
                  )),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startWorkPlace,
              index: "2",
              shift: shift,
              title: "Workplace Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shift,
                        photoType: PhotoType.startWorkPlace,
                      ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: context.colors.primaryGreen,
                  )),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startCamera,
              index: "3",
              shift: shift,
              title: "Camera Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shift,
                        photoType: PhotoType.startCamera,
                      ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: context.colors.primaryGreen,
                  )),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startLaptop,
              index: "4",
              shift: shift,
              title: "Laptop Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shift,
                        photoType: PhotoType.startLaptop,
                      ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: context.colors.primaryGreen,
                  )),
            ),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.startWires,
              index: "5",
              shift: shift,
              title: "Wires Photo",
              trailing: IconButton(
                  onPressed: () => _addPhoto(
                        shiftViewModelNotifier,
                        shift,
                        photoType: PhotoType.startWires,
                      ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: context.colors.primaryGreen,
                  )),
            ),
            Divider(),
            SnapperShiftDetailItem(
              shiftPhotoType: PhotoType.none,
              shift: shift,
              index: "6",
              title: "Shift start report",
              onTap: () => context.pushRoute(SnapperShiftStartReportRoute(
                snapperShift: shift!,
              )),
              trailing: _isStartReportCompleted((shift?.shiftStart))
                  ? Icon(
                      Icons.checklist_rtl,
                      color: context.colors.secondaryGreen,
                    )
                  : Icon(
                      Icons.list,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, SnapperShift? shift) {
    return AppBar(
      title: Text("Shift start"),
      actions: [
        buildStatus(context, shift),
        DDimension.bigPadding.horizontalBox,
      ],
    );
  }

  Widget buildStatus(BuildContext context, SnapperShift? shift) {
    return shift?.shiftStart.isCompleted ?? false
        ? ShiftStatusWidget(
          title: "Completed",
          backgroundColor: context.colors.secondaryGreen,
        )
        :ShiftStatusWidget(
          title: "Incomplete",
          titleColor: Colors.black,
          backgroundColor: context.colors.primaryYellow,
        ) ;
  }

// Function to handle successful submission

// Function to handle invalid submission

  bool _isStartReportCompleted(SnapperShiftStart? shiftStart) =>
      shiftStart?.startReport.startFrames != null &&
      shiftStart?.startReport.startBrokenFrames != null &&
      shiftStart?.startReport.startPaperSets != null &&
      shiftStart?.startReport.startBrokenPaperSets != null &&
      shiftStart?.startReport.startPrints != null;

  void _addPhoto(
    SnapperShiftViewModel shiftViewModelNotifier,
    SnapperShift? shift, {
    required PhotoType photoType,
  }) async {
    final file = await PhotoRepo.takePhoto(ImageSource.camera);
    if (file != null) {
      PhotoModel? newPhoto = getPhotoModel(shift, file, photoType);

      final updatedShift = shift?.copyWith(
        updatedAt: DateTime.now(),
        shiftStart: shift.shiftStart
            .updateShiftStartPhoto(
              photoType,
              newPhoto: newPhoto,
            )!
            .copyWith(
              updatedAt: DateTime.now(),
            ),
      );
      shiftViewModelNotifier.uploadMedia(
        file,
        newPhoto: newPhoto,
        shift: updatedShift,
        isVideo: false,
      );
    }
  }

  PhotoModel getPhotoModel(
    SnapperShift? shift,
    File? photoFile,
    PhotoType photoType,
  ) {
    return PhotoModel(
      id: const Uuid().v1(),
      photoType: photoType,
      createdAt: DateTime.now(),
      restaurantName: shift?.restaurantName,
      shiftId: shift?.id,
    );
  }
}

class ShiftStatusWidget extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  const ShiftStatusWidget({
    super.key, required this.title, required this.backgroundColor, this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DDimension.biggerPadding,
        vertical: DDimension.mediumPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: DDimension.hugePadding.radius,
        color: backgroundColor,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: titleColor,
        ),
      ),
    );
  }
}
