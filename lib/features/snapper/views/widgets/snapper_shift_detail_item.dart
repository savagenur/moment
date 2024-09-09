import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/build_context_extension.dart';

class SnapperShiftDetailItem extends StatelessWidget {
  final String index;
  final String title;
  final DateTime? date;
  final String? imageUrl;
  final VoidCallback? onTap;
  final Widget? trailing;
  
  const SnapperShiftDetailItem({
    super.key,
    required this.index,
    required this.title,
    this.date,
     this.imageUrl,
    this.onTap,
    this.trailing,
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
          if (imageUrl != null)
            CachedNetworkImage(
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              imageUrl: imageUrl!,
            ),
        ],
      ),
      trailing: trailing,
    );
  }
}
