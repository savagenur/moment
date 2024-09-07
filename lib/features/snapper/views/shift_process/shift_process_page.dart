// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/widgets/primary_button.dart';
import 'package:moment/features/auth/views/sign_in/sign_in_page.dart';
import 'package:moment/features/snapper/models/snapper_mocks.dart';
import 'package:moment/features/snapper/views/shift_start/snapper_shift_start_page.dart';
import 'package:moment/features/snapper/views/widgets/snapper_shift_detail_item.dart';

@RoutePage()
class SnapperShiftProcessPage extends ConsumerWidget {
  const SnapperShiftProcessPage({super.key});

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
                index: "1", title: "Restaurant Video", imageUrl: SnapperMocks.restaurantImage),
            SnapperShiftDetailItem(
                index: "2", title: "Restaurant Video", imageUrl: SnapperMocks.restaurantImage),
            SnapperShiftDetailItem(
                index: "3", title: "Restaurant Video", imageUrl: SnapperMocks.restaurantImage),
            
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PrimaryButton(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              DDimension.mediumPadding.horizontalBox,
              Text("Add video"),
            ],
          ),
          margin: DDimension.bigPadding.all,
          onTap: () {},
        ),
      ),
    );
  }
}

