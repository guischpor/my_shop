import 'package:flutter/material.dart';

SnackBar showSnackBarDialog({
  Color? backgroundColor,
  required String labelActionButton,
  Color? textColorLabel,
  required void Function() onPressed,
  required Widget contentWidget,
}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: labelActionButton,
      textColor: textColorLabel,
      onPressed: onPressed,
    ),
    content: contentWidget,
  );
}

// class ShowSnackBarDialog extends SnackBar {
//   final Color? backgroundColor;
//   final String labelActionButton;
//   final Color? textColorLabel;
//   final void Function() onPressed;
//   final Widget contentWidget;

//   const ShowSnackBarDialog({
//     this.backgroundColor,
//     this.textColorLabel,
//     required this.onPressed,
//     required this.labelActionButton,
//     required this.contentWidget,
//   });

//   Widget build(BuildContext context) {
//     return SnackBar(
//       backgroundColor: backgroundColor,
//       duration: const Duration(seconds: 2),
//       action: SnackBarAction(
//         label: labelActionButton,
//         textColor: textColorLabel,
//         onPressed: onPressed,
//       ),
//       content: contentWidget,
//     );
//   }
// }


