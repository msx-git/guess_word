import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guess_word/controller/word_controller.dart';

final wordController = Get.put(WordController());

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  int currentIndex = 0;

  String currentWord = '';
  String options = '';

  setCurrentWord(word) => setState(() => currentWord = word);

  generateOptions(String word) {
    options = currentWord +
        List.generate(
          (word.length.isEven ? 2 : 3),
          (index) => word[Random().nextInt(word.length)],
        ).join();
    var random = options.split('');
    random.shuffle();
    options = random.join();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setCurrentWord(wordController.words[currentIndex].word);
      generateOptions(wordController.words[currentIndex].word);
    });
  }

  @override
  Widget build(BuildContext context) {
    final words = wordController.words;
    return Obx(
      () {
        return Scaffold(
          body: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/background.svg',
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 3.6.h, 15.w, 67.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: const Alignment(-0.1, 1),
                            children: [
                              SvgPicture.asset('assets/images/left.svg'),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontFamily: 'Comic',
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xff484848),
                                ),
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset('assets/images/center.svg'),
                              Text(
                                '${currentIndex + 1}',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontFamily: 'Comic',
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          Stack(
                            alignment: const Alignment(0.1, 1),
                            children: [
                              SvgPicture.asset('assets/images/right.svg'),
                              Text(
                                '50',
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontFamily: 'Comic',
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xff484848),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('assets/images/add_hint.svg'),
                            SvgPicture.asset('assets/images/add_diamond.svg'),
                          ],
                        ),
                      ),

                      /// PROMPT
                      Expanded(
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: words.length,
                          onPageChanged: (index) {
                            if (currentIndex != index) {
                              currentIndex = index;
                              setCurrentWord(words[index].word);
                              generateOptions(words[index].word);
                            }
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: Center(
                                child: Text(
                                  words[index].prompt,
                                  style: TextStyle(
                                    fontFamily: 'Comic',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 28.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      /// GUESSING WORD
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 5.w,
                        runSpacing: 5.h,
                        children: [
                          ...List.generate(
                            currentWord.length,
                            (i) {
                              return Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffFFFFFF).withOpacity(0.26),
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: const Color(0xff3E87FF),
                                    width: 3.r,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 66.h),

                      /// OPTIONS
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 8.h,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          options.length,
                          (i) {
                            return Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: const Color(0xff3E87FF),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                options[i].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Comic',
                                  fontSize: 24.sp,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
