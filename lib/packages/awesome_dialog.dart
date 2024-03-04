import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog awesomeDialog({
  required BuildContext context,
  DialogType? dialogType = DialogType.info,
  String? title,
  description,
}) {
  return AwesomeDialog(
    context: context,
    barrierColor: Theme.of(context).dialogTheme.backgroundColor,
    title: title ?? 'Alert',
    desc: description,
  );
}
