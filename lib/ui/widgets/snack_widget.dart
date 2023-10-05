import 'package:flutter/material.dart';

miSnackBarSuccess(BuildContext context, String texto, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: color,
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
            ),
            Text(texto),
          ],
        )),
  );
}
