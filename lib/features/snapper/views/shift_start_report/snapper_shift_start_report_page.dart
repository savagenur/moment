// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/widgets/primary_button.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/snapper_start_report/snapper_start_report_model.dart';
import 'package:moment/features/shift/view_models/snapper/snapper_shift_viewmodel.dart';

@RoutePage()
class SnapperShiftStartReportPage extends HookConsumerWidget {
  final SnapperShift snapperShift;
  const SnapperShiftStartReportPage({
    super.key,
    required this.snapperShift,
  });
  String intToTextConverter(int? amount) {
    return amount != null ? amount.toString() : "";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapperStartReport =
        snapperShift.startReportModel as SnapperStartReport?;
    final framesController = useTextEditingController(
        text: intToTextConverter(snapperStartReport?.startFrames));
    final brokenFramesController = useTextEditingController(
        text: intToTextConverter(snapperStartReport?.startBrokenFrames));
    final paperSetsController = useTextEditingController(
        text: intToTextConverter(snapperStartReport?.startPaperSets));
    final brokenPaperSetsController = useTextEditingController(
        text: intToTextConverter(snapperStartReport?.startBrokenPaperSets));
    final startPrintsController = useTextEditingController(
        text: intToTextConverter(snapperStartReport?.startPrints));
    useEffect(
      () {
        Timer? _debounce;

        void updateShift() {
          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(const Duration(milliseconds: 300), () {
            ref.read(snapperShiftViewModelProvider.notifier).setLocalShift(
                  snapperShift.copyWith(
                    startReportModel: SnapperStartReport(
                      startFrames: textToIntConverter(framesController),
                      startBrokenFrames:
                          textToIntConverter(brokenFramesController),
                      startPaperSets: textToIntConverter(paperSetsController),
                      startBrokenPaperSets:
                          textToIntConverter(brokenPaperSetsController),
                      startPrints: textToIntConverter(startPrintsController),
                    ),
                  ),
                );
          });
        }

        // Add listeners to each controller to trigger the update function
        framesController.addListener(updateShift);
        brokenFramesController.addListener(updateShift);
        paperSetsController.addListener(updateShift);
        brokenPaperSetsController.addListener(updateShift);
        startPrintsController.addListener(updateShift);

        // Cleanup listeners when the widget is disposed
        return () {
          framesController.removeListener(updateShift);
          brokenFramesController.removeListener(updateShift);
          paperSetsController.removeListener(updateShift);
          brokenPaperSetsController.removeListener(updateShift);
          startPrintsController.removeListener(updateShift);
        };
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Shift Start Report"),
      ),
      body: Padding(
        padding: DDimension.bigPadding.all,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: buildTextField(context,
                      controller: framesController,
                      label: "Total Frames",
                      textInputAction: TextInputAction.next),
                ),
                DDimension.bigPadding.horizontalBox,
                Expanded(
                  child: buildTextField(context,
                    textInputAction: TextInputAction.next,
                    controller: brokenFramesController,
                    label: "Broken Frames",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: buildTextField(context,
                    textInputAction: TextInputAction.next,
                    controller: paperSetsController,
                    label: "Total Paper sets",
                  ),
                ),
                DDimension.bigPadding.horizontalBox,
                Expanded(
                  child: buildTextField(context,
                    textInputAction: TextInputAction.next,
                    controller: brokenPaperSetsController,
                    label: "Broken Paper sets",
                  ),
                ),
              ],
            ),
            buildTextField(context,
              controller: startPrintsController,
              label: "Paper sets in stamp",
            ),
          ],
        ),
      ),
    );
  }

  TextField buildTextField(
    BuildContext context,
    {
    required TextEditingController controller,
    required String label,
    TextInputAction? textInputAction,
  }) {
    return TextField(
      controller: controller,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        label: Text(
          label,
        ),
      ),
    );
  }
}

int? textToIntConverter(TextEditingController controller) {
  final text = controller.text;
  return text.isNotEmpty ? int.parse(text) : null;
}
