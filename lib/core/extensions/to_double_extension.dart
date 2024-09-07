import 'package:flutter/material.dart';

extension ToDoubleExtension on double {
  SizedBox get horizontalBox => SizedBox(
        width: this,
      );
  SizedBox get verticalBox => SizedBox(
        height: this,
      );
  EdgeInsets get all => EdgeInsets.all(this);
  EdgeInsets get right => EdgeInsets.only(right: this);
  EdgeInsets get left => EdgeInsets.only(left: this);
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: this);
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: this);

  BorderRadius get radius => BorderRadius.circular(this);
}
