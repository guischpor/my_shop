import 'package:flutter/material.dart';

Future<void> showDialogMessage({
  required BuildContext context,
  required String message,
  required String textButton,
  required void Function()? onTapButton,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        height: 220,
        child: Column(
          children: [
            Image.asset(
              'assets/images/warning.png',
              height: 100,
            ),
            const SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: onTapButton,
              child: Text(textButton),
            )
          ],
        ),
      ),
    ),
  );
}
