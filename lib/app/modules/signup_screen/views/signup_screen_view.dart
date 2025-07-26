import 'package:firebase1/app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/round_button.dart';
import '../controllers/signup_screen_controller.dart';

class SignupScreenView extends GetView<SignupScreenController> {
  const SignupScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupScreenController controller = Get.put(SignupScreenController());

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    FirebaseAuth auth = FirebaseAuth.instance;

    dispose() {
      emailController.dispose();
      passwordController.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        title: const Text('Sign up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 70),

              Obx(
                () =>
                    controller.isLoading.value
                        ? CircularProgressIndicator()
                        : RoundButton(
                          title: 'Sign Up',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              controller.isLoading.value = true;

                              // Perform login action

                              auth
                                  .createUserWithEmailAndPassword(
                                    email: emailController.text.toString(),
                                    password:
                                        passwordController.text.toString(),
                                  )
                                  .then((value) {
                                    controller.isLoading.value = false;
                                    Get.toNamed('/login-screen');
                                  })
                                  .onError((error, stackTrace) {
                                    controller.isLoading.value = false;
                                    utils().toastMessage(error.toString());
                                  });
                            }

                          },
                        ),
              ),

              Row(
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/login-screen');
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
