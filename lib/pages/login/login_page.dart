import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:small_chat_app/components/c_button.dart';
import 'package:small_chat_app/controllers%20/services/auth/auth_service.dart';
import 'package:small_chat_app/pages/home/home_page.dart';
import 'package:small_chat_app/pages/login/widgets/login_textfield.dart';
import 'package:small_chat_app/utils/text_utils.dart';

import '../register/register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   
  LoginPage({super.key});

  void login() async {
    final authService = AuthService();
    try{
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
      Get.offAll(()=> HomePage());
    }
    catch(e){
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }



    // Get.to(()=> HomePage());
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Iconsax.message, size: 100, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
            Text(TextUtils.welcome, style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 50),
            LoginTextfield(
              hintText: TextUtils.email,
              obscureText: false,
              controller: emailController,
            ),
            const SizedBox(height: 10),
            LoginTextfield(
              hintText: TextUtils.password,
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            CButton(text: TextUtils.login,
            onPressed: login,
            ),
            const SizedBox(height: 8),
            const Text(TextUtils.or),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text(TextUtils.dontHaveAnAccount, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              TextButton(
                onPressed: () => Get.to(() => RegisterPage()),
                child: Text(TextUtils.registerNow, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),),
              )
            ],)

            



          ],
        ),
      ),
    );
  }
}