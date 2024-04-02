import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../components/c_button.dart';
import '../../utils/text_utils.dart';
import '../login/widgets/login_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  void register() {
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
            Text(TextUtils.registerNow, style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.primary)),
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
            const SizedBox(height: 10),
            LoginTextfield(
              hintText: TextUtils.password,
              obscureText: true,
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 20),
            CButton(text: TextUtils.signUp,
            onPressed: register,
            ),
            const SizedBox(height: 8),
            const Text(TextUtils.or),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text(TextUtils.alreadyHaveAccount, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(TextUtils.login, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),),
              )
            ],)

            



          ],
        ),
      ),
    );
  }
}