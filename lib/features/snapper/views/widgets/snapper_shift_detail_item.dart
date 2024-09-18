import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/enums/snapper_shift_photo_type.dart';
import 'package:moment/core/extensions/build_context_extension.dart';
import 'package:moment/features/app/widgets/loader.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';

class SnapperShiftDetailItem extends StatelessWidget {
  final String index;
  final String title;
  final DateTime? date;
  final SnapperShift? shift;
  final SnapperShiftPhotoType shiftPhotoType;
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
    this.shiftPhotoType = SnapperShiftPhotoType.none,
  });

  @override
  Widget build(BuildContext context) {
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
              if (shiftPhotoType.getPhoto(shift)?.isLoading ?? false)
                const Positioned.fill(child: Loader(color: Colors.white,)),

            ],
          )
        ],
      ),
      trailing: trailing,
    );
  }

  Widget buildImage() {
    // assert(shiftLocal != null || shiftRemote != null);

    final latestPhoto = shiftPhotoType.getPhoto(shift as SnapperShift?);
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
}
