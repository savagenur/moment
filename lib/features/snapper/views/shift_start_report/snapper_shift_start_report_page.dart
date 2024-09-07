import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/widgets/primary_button.dart';

@RoutePage()
class SnapperShiftStartReportPage extends ConsumerStatefulWidget {
  const SnapperShiftStartReportPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SnapperShiftStartReportPageState();
}

class _SnapperShiftStartReportPageState
    extends ConsumerState<SnapperShiftStartReportPage> {
  @override
  Widget build(BuildContext context) {
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        "Total Frames",
                      ),
                    ),
                  ),
                ),
                DDimension.bigPadding.horizontalBox,
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        "Broken Frames",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        "Total Paper sets",
                      ),
                    ),
                  ),
                ),
                DDimension.bigPadding.horizontalBox,
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        "Broken Paper sets",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text(
                  "Paper sets in stamp",
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PrimaryButton(
          margin: DDimension.bigPadding.all,
          title: Text("Save"), onTap: () {
          
        },),
      ),
    );
  }
}
