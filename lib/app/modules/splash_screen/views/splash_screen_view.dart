import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 20.0, color: Colors.purple),
          child: AnimatedTextKit(
            animatedTexts: [WavyAnimatedText('Welcome to Firebase App')],
            totalRepeatCount: 2,

            //isRepeatingAnimation: true,
            onFinished: () {
              Get.back();
              user != null
                  ? Get.toNamed('/post-screen')
                  : Get.toNamed('/login-screen');
            },
            onTap: () {
              Get.back();
              user != null
                  ? Get.toNamed('/post-screen')
                  : Get.toNamed('/login-screen');

            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
          user != null
              ? Get.toNamed('/post-screen')
              : Get.toNamed('/login-screen');
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
