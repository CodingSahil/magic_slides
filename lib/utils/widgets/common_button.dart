import 'package:flutter/material.dart';
import 'package:magic_slides/utils/theme-text/text-style.dart';

class ClickablePrimaryButton extends StatelessWidget {
  const ClickablePrimaryButton({
    super.key,
    required this.label,
    this.labelFontSize = 15,
    this.width,
    this.height,
    this.onTap,
    this.buttonColor,
    this.fontColor,
    this.isLoader = false,
    this.loader,
  });

  final String label;
  final double labelFontSize;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? fontColor;
  final bool isLoader;
  final Widget? loader;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? MediaQuery.sizeOf(context).height * 0.055,
        decoration: BoxDecoration(
          color: buttonColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buttonColor ?? Theme.of(context).colorScheme.primary, width: 1.5),
        ),
        alignment: Alignment.center,
        child: isLoader && loader != null
            ? loader
            : AppTextTheme.text(
                label,
                fontSize: labelFontSize,
                color: fontColor ?? Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w800,
              ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key,
    required this.label,
    this.labelFontSize = 15,
    this.width,
    this.height,
    this.onTap,
    this.fontColor,
    this.borderColor,
    this.isLoader = false,
    this.loader,
  });

  final String label;
  final double labelFontSize;
  final double? width;
  final double? height;
  final void Function()? onTap;
  final Color? fontColor;
  final Color? borderColor;
  final bool isLoader;
  final Widget? loader;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap:  onTap,
      child: Container(
        width: width,
        height: height ?? MediaQuery.sizeOf(context).height * 0.055,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ?? (fontColor ?? Theme.of(context).colorScheme.primary),
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: isLoader && loader != null
            ? loader
            : AppTextTheme.text(
                label,
                fontSize: labelFontSize,
                color: fontColor ?? Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
      ),
    );
  }
}
