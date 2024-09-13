import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/view_models/snapper/snapper_shift_viewmodel.dart';

class SnapperShiftPage extends HookConsumerWidget {
  const SnapperShiftPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapperShiftViewModel =
        ref.read(snapperShiftViewModelProvider.notifier);
    final activeShifts =
        ref.watch(snapperShiftViewModelProvider).value?.activeShifts;
    
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
                  child: Text(
                    "${activeShift.startTime}\n${activeShift.restaurantName}",
                  ),
                ),
                IconButton(
                    onPressed: () async{
                      await snapperShiftViewModel.getLocalShift();
                      // await snapperShiftViewModel.setLocalShift();
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.green,
                    )),
              ],
            ),
            children: [
              ListTile(
                onTap: () => context.pushRoute( SnapperShiftStartRoute(
                  shiftRemote: activeShift,   
                )),
                title: Text("Start"),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ),
              ListTile(
                onTap: () =>
                    context.pushRoute(const SnapperShiftProcessRoute()),
                title: Text("In procces"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                onTap: () => context.pushRoute(const SnapperShiftEndRoute()),
                title: Text("End"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
