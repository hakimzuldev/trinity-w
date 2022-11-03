import 'package:flutter/cupertino.dart';

class Modal {
  static Future<void> notificationModal({
    required context, required String title, required Widget content
  }) async {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: content,
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}