// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/app/widgets/primary_button.dart';
import 'package:moment/features/snapper/models/snapper_mocks.dart';
import 'package:moment/features/snapper/views/widgets/snapper_shift_detail_item.dart';

@RoutePage()
class SnapperShiftStartPage extends ConsumerWidget {
  const SnapperShiftStartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shift start"),
      ),
      body: SingleChildScrollView(
        padding: DDimension.mediumPadding.all,
        child: Column(
          children: [
            SnapperShiftDetailItem(
                index: "1",
                title: "Clothes Photo",
                imageUrl: SnapperMocks.clothImage),
            SnapperShiftDetailItem(
                index: "2",
                title: "Workplace Photo",
                imageUrl: SnapperMocks.clothImage),
            SnapperShiftDetailItem(
                index: "3",
                title: "Camera Photo",
                imageUrl: SnapperMocks.clothImage),
            SnapperShiftDetailItem(
                index: "4",
                title: "Laptop Photo",
                imageUrl: SnapperMocks.clothImage),
            SnapperShiftDetailItem(
                index: "5",
                title: "Wires Photo",
                imageUrl: SnapperMocks.clothImage),
            SnapperShiftDetailItem(
              index: "6",
              title: "Shift start report",
              onAdd: () => context.pushRoute(const SnapperShiftStartReportRoute()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PrimaryButton(
          title: Text("Submit"),
          margin: DDimension.bigPadding.all,
          onTap: () {},
        ),
      ),
    );
  }
}
