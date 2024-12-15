import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moment/core/converters/date_time_converter.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/features/app/constants/constants.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/view_models/snapper/bloc/snapper_shift_viewmodel.dart';
import 'package:moment/features/snapper/views/shift_start/snapper_shift_start_page.dart';

class SnapperShiftPage extends HookConsumerWidget {
  const SnapperShiftPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapperShiftViewModel =
        ref.read(snapperShiftViewModelProvider.notifier);
    final activeShifts =
        ref.watch(snapperShiftViewModelProvider).activeShifts.value;

    return Scaffold(
      appBar: AppBar(
        title: Text("Shift"),
      ),
      body: ListView.builder(
        itemCount: activeShifts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final activeShift = activeShifts![index] as SnapperShift;
          return ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            enabled: index == 0,
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${activeShift.restaurantName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateTimeConverter.toTextTimeAndDate(
                            activeShift.startTime!),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      // await snapperShiftViewModel.setLocalShift();
                    },
                    icon: Icon(
                      Icons.location_on,
                    )),
              ],
            ),
            children: [
              ListTile(
                  onTap: () => context.pushRoute(SnapperShiftStartRoute(
                        snapperShift: activeShift,
                      )),
                  title: Text("Start"),
                  trailing: activeShift.shiftStart.isCompleted
                      ? ShiftStatusWidget(
                          title: "Completed",
                          backgroundColor: completeColor,
                        )
                      : ShiftStatusWidget(
                          title: "Incomplete",
                          titleColor: Colors.black,
                          backgroundColor: inProcessColor,
                        )),
              ListTile(
                onTap: () =>
                    context.pushRoute(SnapperShiftEndRoute(snapperShift: activeShift)),
                title: Text("End"),
                trailing: activeShift.shiftEnd.isCompleted
                      ? ShiftStatusWidget(
                          title: "Completed",
                          backgroundColor: completeColor,
                        )
                      : ShiftStatusWidget(
                          title: "Incomplete",
                          titleColor: Colors.black,
                          backgroundColor: inProcessColor,
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}
