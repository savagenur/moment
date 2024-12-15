// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/converters/date_time_converter.dart';
import 'package:moment/core/converters/time_of_day_converter.dart';
import 'package:moment/core/enums/printer_type.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/constants/constants.dart';
import 'package:moment/features/shift/models/end_report/end_report_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/view_models/snapper/bloc/snapper_shift_viewmodel.dart';

@RoutePage()
class SnapperShiftEndReportPage extends HookConsumerWidget {
  final SnapperShift snapperShift;
  const SnapperShiftEndReportPage({
    super.key,
    required this.snapperShift,
  });
  String intToTextConverter(int? amount) {
    return amount != null ? amount.toString() : "";
  }

  String doubleToTextConverter(double? amount) {
    return amount != null
        ? double.parse(amount.toStringAsFixed(2)).toString()
        : "";
  }

  String dateToTextConverter(DateTime? date) {
    return date != null ? DateTimeConverter.toText(date) : "";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Timer? debounce;
    final shiftViewModelNotifier =
        ref.read(snapperShiftViewModelProvider.notifier);
    final snapperEndReport = snapperShift.shiftEnd.endReport;
    DateTime? startTime = snapperEndReport.startTime;
    DateTime? endTime = snapperEndReport.endTime;

    final startTimeController = useTextEditingController(
        text: dateToTextConverter(snapperEndReport.startTime));
    final endTimeController = useTextEditingController(
        text: dateToTextConverter(snapperEndReport.endTime));
    final hourPriceController = useTextEditingController(
        text: doubleToTextConverter(snapperEndReport.hourPrice));
    final framePriceController = useTextEditingController(
        text: doubleToTextConverter(snapperEndReport.framePrice));
    final salarySupplementController = useTextEditingController(
        text: doubleToTextConverter(snapperEndReport.salarySupplement));
    final taxiPriceController = useTextEditingController(
        text: doubleToTextConverter(snapperEndReport.taxiPrice));
    final otherController = useTextEditingController(
        text: doubleToTextConverter(snapperEndReport.other));
    final lostFrameController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.lostFrame));
    final soldFrameCashController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.soldFrameCash));
    final soldFrameCardController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.soldFrameCard));
    final paperSetSupplyController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.paperSetSupply));
    final endFramesController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.endFrames));
    final endBrokenFramesController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.endBrokenFrames));
    final endPaperSetsController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.endPaperSets));
    final endBrokenPaperSetsController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.endBrokenPaperSets));
    final endPrintsController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.endPrints));
    final totalSoldFrameController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.totalSoldFrame));
    final frameSupplyController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.frameSupply));
    final frameReturnController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.frameReturn));
    final frameRemoveController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.frameRemove));
    final frameFreeController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.frameFree));
    final printedPaperAmountController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.printedPaperAmount));
    final soldRemainFrameDifferenceController = useTextEditingController(
        text: intToTextConverter(snapperEndReport.soldRemainFrameDifference));
    final managerCashController = useTextEditingController(
        text: doubleToTextConverter(snapperEndReport.managerCash));
    final startEndFrameDifferenceController = useTextEditingController(
      text: intToTextConverter(
        snapperEndReport.startEndFrameDifference(
          snapperShift.shiftStart.startReport.startFrames,
        ),
      ),
    );

    useEffect(
      () {
        void updateShift() {
          shiftViewModelNotifier.updateShiftEndReport(
            snapperShift.copyWith(
              shiftEnd: snapperShift.shiftEnd.copyWith(
                endReport: snapperShift.shiftEnd.endReport.copyWith(
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                  salarySupplement: double.parse(soldFrameCashController.text),
                  taxiPrice: double.parse(soldFrameCashController.text),
                  other: double.parse(soldFrameCashController.text),
                  lostFrame: int.parse(soldFrameCashController.text),
                  soldFrameCash: int.parse(soldFrameCashController.text),
                  soldFrameCard: int.parse(soldFrameCashController.text),
                  paperSetSupply: int.parse(soldFrameCashController.text),
                  endFrames: int.parse(soldFrameCashController.text),
                  endBrokenFrames: int.parse(soldFrameCashController.text),
                  endPaperSets: int.parse(soldFrameCashController.text),
                  endBrokenPaperSets: int.parse(soldFrameCashController.text),
                  endPrints: int.parse(soldFrameCashController.text),
                ),
              ),
            ),
          );
        }

        void updateShiftTimer() {
          if (debounce?.isActive ?? false) debounce!.cancel();
          debounce = Timer(const Duration(milliseconds: 2000), () {
            updateShift();
          });
        }

        startTimeController.addListener(updateShiftTimer);
        endTimeController.addListener(updateShiftTimer);
        hourPriceController.addListener(updateShiftTimer);
        framePriceController.addListener(updateShiftTimer);
        salarySupplementController.addListener(updateShiftTimer);
        taxiPriceController.addListener(updateShiftTimer);
        otherController.addListener(updateShiftTimer);
        lostFrameController.addListener(updateShiftTimer);
        soldFrameCashController.addListener(updateShiftTimer);
        soldFrameCardController.addListener(updateShiftTimer);
        paperSetSupplyController.addListener(updateShiftTimer);
        endFramesController.addListener(updateShiftTimer);
        endBrokenFramesController.addListener(updateShiftTimer);
        endPaperSetsController.addListener(updateShiftTimer);
        endBrokenPaperSetsController.addListener(updateShiftTimer);
        endPrintsController.addListener(updateShiftTimer);

        // Cleanup listeners when the widget is disposed
        return () {
          if (debounce?.isActive ?? false) {
            debounce!.cancel();
            // updateShift(); // Ensures the last update is made before disposal
          }
          startTimeController.removeListener(updateShiftTimer);
          endTimeController.removeListener(updateShiftTimer);
          hourPriceController.removeListener(updateShiftTimer);
          framePriceController.removeListener(updateShiftTimer);
          salarySupplementController.removeListener(updateShiftTimer);
          taxiPriceController.removeListener(updateShiftTimer);
          otherController.removeListener(updateShiftTimer);
          lostFrameController.removeListener(updateShiftTimer);
          soldFrameCashController.removeListener(updateShiftTimer);
          soldFrameCardController.removeListener(updateShiftTimer);
          paperSetSupplyController.removeListener(updateShiftTimer);
          endFramesController.removeListener(updateShiftTimer);
          endBrokenFramesController.removeListener(updateShiftTimer);
          endPaperSetsController.removeListener(updateShiftTimer);
          endBrokenPaperSetsController.removeListener(updateShiftTimer);
          endPrintsController.removeListener(updateShiftTimer);
        };
      },
      [
        startTimeController,
        endTimeController,
        hourPriceController,
        framePriceController,
        salarySupplementController,
        taxiPriceController,
        otherController,
        lostFrameController,
        soldFrameCashController,
        soldFrameCardController,
        paperSetSupplyController,
        endFramesController,
        endBrokenFramesController,
        endPaperSetsController,
        endBrokenPaperSetsController,
        endPrintsController,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Shift End Report"),
      ),
      body: SingleChildScrollView(
        padding: DDimension.bigPadding.all,
        child: Column(
          children: [
            buildDivider(context, "General"),
            buildTwoTextField(
              firstTextField: buildTextField(context,
                  textInputAction: TextInputAction.next,
                  controller: framePriceController,
                  label: "Frame price",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      regexDouble2,
                    ),
                  ]),
              secondTextField: buildTextField(context,
                  textInputAction: TextInputAction.next,
                  controller: salarySupplementController,
                  label: "Salary supplement",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      regexDouble2,
                    ),
                  ]),
            ),
            DDimension.bigPadding.verticalBox,
            buildCheckBoxTile(
              context,
              value: false,
              title: "Have you come to a nearby city?",
              onChanged: (p0) {},
            ),
            DDimension.bigPadding.verticalBox,
            buildCheckBoxTile(context,
                value: true,
                title:
                    "(only if you worked with assistant) The assistant worked less than 50% of the time",
                onChanged: (p0) {}),
            DDimension.biggerPadding.verticalBox,
            buildDivider(context, "Expenses"),
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: lostFrameController,
                label: "Lost frames",
              ),
              secondTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: taxiPriceController,
                label: "Taxi price",
              ),
            ),
            DDimension.bigPadding.verticalBox,
            buildTextField(
              context,
              controller: otherController,
              label: "Other",
            ),
            DDimension.biggerPadding.verticalBox,
            buildDivider(context, "Sales"),
            buildTextField(
              context,
              controller: soldFrameCashController,
              label: "Cash sold frames",
            ),
            DDimension.bigPadding.verticalBox,
            buildTextField(
              context,
              controller: soldFrameCardController,
              label: "Card sold frames",
            ),
            DDimension.bigPadding.verticalBox,
            buildTextField(
              context,
              controller: totalSoldFrameController,
              readOnly: true,
              label: "Total sold frames",
            ),
            DDimension.biggerPadding.verticalBox,
            buildDivider(context, "Supplies"),
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: paperSetSupplyController,
                label: "Paper set supply",
              ),
              secondTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: frameSupplyController,
                label: "Frames supply",
              ),
            ),
            DDimension.bigPadding.verticalBox,
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: frameReturnController,
                label: "Frames returned",
              ),
              secondTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: frameFreeController,
                label: "Frames given free",
              ),
            ),
            DDimension.bigPadding.verticalBox,
            buildTextField(
              context,
              textInputAction: TextInputAction.next,
              controller: frameRemoveController,
              label: "Frames remove",
            ),
            DDimension.biggerPadding.verticalBox,
            buildDivider(context, "End"),
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                onTap: () async {
                  startTime = await showDatePicker(
                    context: context,
                    initialDate: startTime??DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (startTime == null) return;

                  final timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                      startTime!,
                    ),
                  );

                  if (timeOfDay == null) {
                    startTime = null;
                  } else {
                    startTimeController.text =
                        TimeOfDayConverter.toText(timeOfDay);
                  }
                },
                readOnly: true,
                controller: startTimeController,
                label: "Start time",
              ),
              secondTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                onTap: () async {
                  final timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (timeOfDay != null) {
                    endTimeController.text =
                        TimeOfDayConverter.toText(timeOfDay);
                  }
                },
                readOnly: true,
                controller: endTimeController,
                label: "End time",
              ),
            ),
            DDimension.bigPadding.verticalBox,
            LayoutBuilder(
              builder: (context, constraints) {
                return DropdownButtonFormField<PrinterType>(
                  value: snapperEndReport.printerType,
                  onChanged: (value) {},
                  items: PrinterType.values
                      .map(
                        (e) => DropdownMenuItem<PrinterType>(
                          value: e,
                          child: SizedBox(
                            width: constraints.maxWidth - 70,
                            child: Text(
                              e.detail,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            DDimension.bigPadding.verticalBox,
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: endFramesController,
                label: "End Total Frames",
              ),
              secondTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: endBrokenFramesController,
                label: "End Broken Frames",
              ),
            ),
            DDimension.bigPadding.verticalBox,
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: endPaperSetsController,
                label: "End Total Paper sets",
              ),
              secondTextField: buildTextField(
                context,
                textInputAction: TextInputAction.next,
                controller: endBrokenPaperSetsController,
                label: "End Broken Paper sets",
              ),
            ),
            DDimension.bigPadding.verticalBox,
            buildTextField(
              context,
              controller: endPrintsController,
              label: "End Paper sets in stamp",
            ),
            DDimension.bigPadding.verticalBox,
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                readOnly: true,
                controller: printedPaperAmountController,
                label: "Printed paper amount",
              ),
              secondTextField: buildTextField(
                context,
                readOnly: true,
                controller: soldRemainFrameDifferenceController,
                label: "Sales vs Frames",
              ),
            ),
            DDimension.bigPadding.verticalBox,
            buildTwoTextField(
              firstTextField: buildTextField(
                context,
                readOnly: true,
                controller: startEndFrameDifferenceController,
                label: "Start frame - End frame =",
              ),
              secondTextField: buildTextField(
                context,
                readOnly: true,
                controller: managerCashController,
                label: "Manager cash",
              ),
            ),
            DDimension.bigPadding.verticalBox,
          ],
        ),
      ),
    );
  }

  CheckboxListTile buildCheckBoxTile(
    BuildContext context, {
    required String title,
    required bool? value,
    void Function(bool?)? onChanged,
  }) {
    return CheckboxListTile(
      value: value,
      shape: OutlineInputBorder(
          borderRadius: DDimension.bigPadding.radius,
          borderSide: BorderSide(color: context.colors.grey)),
      onChanged: onChanged,
      title: Text(title),
    );
  }

  Row buildTwoTextField({
    required TextField firstTextField,
    required TextField secondTextField,
  }) {
    return Row(
      children: [
        Expanded(
          child: firstTextField,
        ),
        DDimension.bigPadding.horizontalBox,
        Expanded(
          child: secondTextField,
        ),
      ],
    );
  }

  TextField buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    VoidCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.digitsOnly,
          ],
      decoration: InputDecoration(
        label: Text(
          label,
        ),
      ),
    );
  }

  Widget buildDivider(BuildContext context, String title) {
    return Padding(
      padding: DDimension.biggerPadding.bottom,
      child: Row(
        children: [
          Expanded(
              child: Divider(
            color: context.colors.grey,
          )),
          Padding(
            padding: DDimension.bigPadding.horizontal,
            child: Text(
              title,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: context.colors.primaryLight,
              ),
            ),
          ),
          Expanded(
              child: Divider(
            color: context.colors.grey,
          )),
        ],
      ),
    );
  }
}

int? textToIntConverter(TextEditingController controller) {
  final text = controller.text;
  return text.isNotEmpty ? int.parse(text) : null;
}
