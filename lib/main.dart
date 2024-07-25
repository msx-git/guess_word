import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 823),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word Guessing Game',
        home: HomeScreen(),
      ),
    );
  }
}
/*

class HomeScreen extends StatelessWidget {
  final WordController wordController = Get.put(WordController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Word'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              return Text(
                wordController.displayWord.value,
                style: const TextStyle(fontSize: 40, letterSpacing: 2),
              );
            }),
            const SizedBox(height: 20),
            TextField(
              onChanged: wordController.guessLetter,
              decoration: const InputDecoration(
                labelText: 'Enter a letter',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                return Text(
                  wordController.message.value,
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WordController extends GetxController {
  var word = 'Apple'.obs;
  var guessedLetters = <String>[].obs;
  var displayWord = ''.obs;
  var message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateDisplayWord();
  }

  void guessLetter(String letter) {
    if (letter.isEmpty) return;
    letter = letter.toUpperCase();

    if (guessedLetters.contains(letter)) {
      message.value = 'You already guessed that letter!';
    } else {
      guessedLetters.add(letter);
      if (word.value.toUpperCase().contains(letter)) {
        message.value = 'Good guess!';
      } else {
        message.value = 'Try again!';
      }
      updateDisplayWord();
    }
  }

  void updateDisplayWord() {
    displayWord.value = word.value
        .split('')
        .map((char) => guessedLetters.contains(char.toUpperCase()) ? char : '_')
        .join(' ');
  }
}
*/
