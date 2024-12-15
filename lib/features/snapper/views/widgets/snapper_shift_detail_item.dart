import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/converters/date_time_converter.dart';
import 'package:moment/core/enums/shift_time_enum.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/widgets/loader.dart';
import 'package:moment/features/photo/models/photo/photo_model.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

class SnapperShiftDetailItem extends ConsumerWidget {
  final String index;
  final String title;
  final DateTime? date;
  final SnapperShift? shift;
  final PhotoType shiftPhotoType;
  final VoidCallback? onTap;
  final VoidCallback? onImageTap;
  final Widget? trailing;
  final ShiftTimeEnum shiftTimeEnum;

  const SnapperShiftDetailItem({
    super.key,
    required this.index,
    this.shiftTimeEnum = ShiftTimeEnum.end,
    required this.title,
    this.date,
    this.onTap,
    this.onImageTap,
    this.trailing,
    required this.shift,
    this.shiftPhotoType = PhotoType.none,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = switch (shiftTimeEnum) {
      ShiftTimeEnum.start => shift?.shiftStart.getPhoto(shiftPhotoType),
      ShiftTimeEnum.end => shift?.shiftEnd.getPhoto(shiftPhotoType),
    };
    return ListTile(
      leading: Text(index),
      horizontalTitleGap: DDimension.smallPadding,
      onTap: onTap,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              if (photo?.createdAt != null)
                Text(
                  DateTimeConverter.toTextTimeAndDate(photo!.createdAt!),
                  style: context.textTheme.bodySmall,
                ),
            ],
          ),
          SizedBox(
            width: 40,
            height: 50,
            child: Stack(
              children: [
                buildImage(context,photo),
                if (photo?.isLoading ?? false)
                  Positioned.fill(
                    child: Loader(
                      color: context.colors.primaryColor,
                    ),
                  ),
                if (photo?.hasError ?? false)
                  const Positioned.fill(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      trailing: trailing,
    );
  }

  Widget buildImage(BuildContext context, PhotoModel? photo) {
    if (photo?.imageUrl != null) {
      return GestureDetector(
        onTap: () async {
          await showMaterialModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: DDimension.bigPadding.all,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: context.textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.cancel_outlined))
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: photo.imageUrl!,
                  )
                ],
              );
            },
          );
        },
        child: ClipRRect(
          borderRadius: DDimension.mediumPadding.radius,
          child: CachedNetworkImage(
            imageUrl: photo!.imageUrl!,
            width: 40,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
