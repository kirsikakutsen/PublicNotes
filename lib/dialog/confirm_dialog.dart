import 'package:flutter/material.dart';
import 'package:notes/theme/colors.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required VoidCallback onPositiveAction,
  required VoidCallback onNegativeAction,
  required String title,
  required String description,
  required String positiveActionTitle,
  required String negativeActionTitle,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColors.confirmDialogBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(color: AppColors.hintTextColor, thickness: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: onNegativeAction,
                  child: Text(
                    negativeActionTitle,
                    style: TextStyle(
                      color: AppColors.hintTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onPositiveAction,
                  child: Text(
                    positiveActionTitle,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
