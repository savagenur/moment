import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/features/app/widgets/loader.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/shift_start/shift_start_model.dart';

class SnapperShiftDetailItem extends ConsumerWidget {
  final String index;
  final String title;
  final DateTime? date;
  final SnapperShift? shift;
  final PhotoType shiftPhotoType;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SnapperShiftDetailItem({
    super.key,
    required this.index,
    required this.title,
    this.date,
    this.onTap,
    this.trailing,
    this.shift,
    this.shiftPhotoType = PhotoType.none,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Text(index),
      // contentPadding: DDimension.smallPadding.horizontal,
      horizontalTitleGap: DDimension.smallPadding,
      onTap: onTap ?? () {},
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(title),
              if (date != null)
                Text(
                  date.toString(),
                  style: context.textTheme.bodySmall,
                ),
            ],
          ),
          Stack(
            children: [
              buildImage(),
              buildLoader(),
              buildError(),
            ],
          )
        ],
      ),
      trailing: trailing,
    );
  }

  Widget buildImage() {
    // assert(shiftLocal != null || shiftRemote != null);

    final latestPhoto = shift?.shiftStart.getPhoto(
      shiftPhotoType,
    );
    if (latestPhoto?.file != null) {
      return Image.file(
        latestPhoto!.file!,
        width: 40,
        fit: BoxFit.cover,
      );
    }

    // If only remote photo exists
    if (latestPhoto?.imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: latestPhoto!.imageUrl!,
        width: 40,
        fit: BoxFit.cover,
      );
    }

    return const SizedBox();
  }

  Widget buildLoader() {
    if (shift?.shiftStart
            .getPhoto(
              shiftPhotoType,
            )
            ?.isLoading ??
        false) {
      return const Positioned.fill(
          child: Loader(
        color: Colors.white,
      ));
    } else {
      return SizedBox();
    }
  }

  Widget buildError() {
    final hasError = shift?.shiftStart
            .getPhoto(
              shiftPhotoType,
            )
            ?.hasError ??
        false;
    if (hasError) {
      return const Positioned.fill(
          child: Icon(
        Icons.error_outline,
        color: Colors.red,
      ));
    } else {
      return const SizedBox();
    }
  }
}
