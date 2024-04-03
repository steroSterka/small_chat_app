import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers /services/auth/auth_service.dart';
import '../../login/login_page.dart';
import '../../settings/settings_page.dart';

class CDrawer extends StatelessWidget {
  const CDrawer({super.key});


    void _logout() async {
    final authService = AuthService();
    try{
      await authService.signOut();
      Get.offAll(()=> LoginPage());
    }
    catch(e){
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

    void goToSettings() {
    Get.to(()=> SettingsPage());
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(child: Icon(Iconsax.message_text, size: 50, color: Theme.of(context).colorScheme.primary)),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Iconsax.home),
            onTap: (){},
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Iconsax.user),
            onTap: (){},
          ),
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Iconsax.settings),
            onTap: goToSettings,
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Iconsax.logout),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}