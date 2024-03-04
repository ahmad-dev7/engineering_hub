import 'package:engineering_hub/backend/api_calls.dart';
import 'package:engineering_hub/constants/kstyledtext.dart';
import 'package:engineering_hub/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:flutter/services.dart';

List<FocusedMenuItem> kMenuItem(
  bool thisUser,
  BuildContext context,
  Message msg,
  Function onEdit,
) {
  return [
    // Copy
    FocusedMenuItem(
      title: const Text('Copy'),
      trailingIcon: const Icon(Icons.content_copy_outlined),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Clipboard.setData(ClipboardData(text: msg.message)).then(
          (_) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).canvasColor,
              duration: const Duration(milliseconds: 1200),
              showCloseIcon: true,
              content: Text(
                'Message copied to clipboard',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        );
      },
    ),
    if (thisUser)
      // Edit
      FocusedMenuItem(
        title: const Text('Edit'),
        trailingIcon: const Icon(Icons.edit_outlined),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: onEdit,
      ),
    if (!thisUser)
      // Contact
      FocusedMenuItem(
        title: const Text('Contact'),
        trailingIcon: const Icon(Icons.call_outlined),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text('Do you want to make call?'),
                content: Text('With ${msg.senderName} ${msg.phoneNo}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: styledText(
                      text: 'Cancel',
                      size: 14,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: styledText(
                      text: 'Yes',
                      size: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    if (!thisUser)
      // Mail
      FocusedMenuItem(
        title: const Text('Mail'),
        trailingIcon: const Icon(Icons.mail_outline),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text('Do you want to send mail?'),
                content: Text('With ${msg.senderName} ${msg.email}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: styledText(
                      text: 'Cancel',
                      size: 14,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: styledText(
                      text: 'Yes',
                      size: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    if (thisUser)
      // Delete
      FocusedMenuItem(
        title: styledText(
          text: 'Delete',
          size: 14,
          color: Colors.white,
        ),
        trailingIcon: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[400],
        onPressed: () {
          Api().deleteMessage(messageId: msg.messageId);
        },
      ),
  ];
}
