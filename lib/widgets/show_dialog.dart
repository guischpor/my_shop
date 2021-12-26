import 'package:flutter/material.dart';

Future<bool?> showDialogModal({
  required BuildContext context,
  required String title,
  required String message,
  required String textButton1,
  required String textButton2,
  required void Function()? onTapButton1,
  required void Function()? onTapButton2,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(textButton1),
          onPressed: onTapButton1,
        ),
        TextButton(
          child: Text(textButton2),
          onPressed: onTapButton2,
        ),
      ],
    ),
  );
}
