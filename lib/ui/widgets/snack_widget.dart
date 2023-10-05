import 'package:flutter/material.dart';

miSnackBarSuccess(BuildContext context, String texto) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.redAccent,
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
