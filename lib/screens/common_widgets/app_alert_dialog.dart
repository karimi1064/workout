import 'package:flutter/material.dart';
import 'package:workout/core/constants/color_constants.dart';
import 'package:workout/core/constants/text_constants.dart';

appAlertDialog(BuildContext context, Function onPressed) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text(TextConstants.cancel),
    onPressed: () => Navigator.of(context).pop(),
  );
  Widget continueButton = TextButton(
    onPressed: () {
      onPressed();
      Navigator.of(context).pop();
    },
    child: const Text(
      TextConstants.delete,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: ColorConstants.errorColor),
    ),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(TextConstants.confirm),
    content: const Text(TextConstants.confirmDelete),
    actionsAlignment: MainAxisAlignment.spaceAround,
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
