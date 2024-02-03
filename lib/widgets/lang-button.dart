import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:start/main.dart';

Widget langButton() {
  return Container(
    child: IconButton(
        onPressed: () {
          if (LocalizedApp.of(navKey.currentState!.context)
                  .delegate
                  .currentLocale
                  .toString() ==
              "ar") {
            changeLocale(navKey.currentState!.context, "en");
          } else {
            changeLocale(navKey.currentState!.context, "ar");
          }
        },
        icon: Icon(Icons.translate)),
  );
}
