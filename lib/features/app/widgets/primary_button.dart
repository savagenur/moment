import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double width;
  final Widget title;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  
  const PrimaryButton({
    super.key,
    this.width = double.infinity,
    required this.title, required this.onTap,  this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
          width: width,
          child: ElevatedButton(onPressed: onTap, child: title)),
    );
  }
}
