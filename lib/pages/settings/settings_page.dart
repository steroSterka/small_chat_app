import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_chat_app/themes/dark_mode.dart';
import 'package:small_chat_app/themes/light_mode.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings Page'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dark Mode"), 
                  CupertinoSwitch(
                        value: Get.isDarkMode,
                        onChanged: (value) {Get.changeTheme(Get.isDarkMode? lightTheme: darkTheme);
;
                        },
                      ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}