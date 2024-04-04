import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../components/c_button.dart';
import '../../controllers /services/auth/auth_service.dart';
import '../../utils/text_utils.dart';
import '../home/home_page.dart';
import '../login/widgets/login_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  void register() async {
    final authService = AuthService();
    if(passwordController.text == confirmPasswordController.text){
      try{
        await authService.registerWithEmailAndPassword(emailController.text, passwordController.text);
        Get.offAll(()=> HomePage());
      }
      catch(e){
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }
    else{
      Get.snackbar('Error', 'Passwords do not match', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    
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
            CTextField(
              hintText: TextUtils.email,
              obscureText: false,
              controller: emailController,
            ),
            const SizedBox(height: 10),
            CTextField(
              hintText: TextUtils.password,
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 10),
            CTextField(
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