import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  static Future<void> onScreen({
    required BuildContext context,
    bool isDismissible = true
  }) {
    return showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => isDismissible,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Theme(
                            data: ThemeData(
                                cupertinoOverrideTheme: const CupertinoThemeData(
                                    brightness: Brightness.dark
                                )
                            ),
                            child: const CupertinoActivityIndicator()
                        )
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}