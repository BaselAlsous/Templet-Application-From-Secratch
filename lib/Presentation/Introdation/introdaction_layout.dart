import 'package:flutter/material.dart';
import 'package:flutter_template/Data/Constant/theme/color_constant.dart';
import 'package:flutter_template/Data/Functions/app_size.dart';
import 'package:flutter_template/Data/Functions/navigation.dart';
import 'package:flutter_template/Presentation/Home/layout.dart';
import 'package:flutter_template/Presentation/Introdation/introdaction_screen_2.dart';
import 'package:flutter_template/Presentation/Introdation/introdaction_screen_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_template/Presentation/Introdation/introdaction_screen_1.dart';

class IntodactionLayout extends StatefulWidget {
  const IntodactionLayout({super.key});

  @override
  State<IntodactionLayout> createState() => _IntodactionLayoutState();
}

class _IntodactionLayoutState extends State<IntodactionLayout> {
  PageController pageController = PageController();
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (index) {
            if (index == 2) {
              setState(() {
                lastPage = true;
              });
            }
          },
          children: const [
            IntrodactionScreen1(),
            IntrodactionScreen2(),
            IntrodactionScreen3(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize(context).width * 0.2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                !lastPage
                    ? CustomButtonIntro(
                        text: 'Next',
                        onTap: () {
                          pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 300,
                              ),
                              curve: Curves.easeIn);
                        },
                      )
                    : CustomButtonIntro(
                        text: 'Done',
                        onTap: () {
                          Navigator.pushReplacement(
                              context, downToTop(const HomeLayout()));
                        },
                      ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: const WormEffect(),
                ),
                CustomButtonIntro(
                  text: 'Skip',
                  onTap: () {
                    pageController.jumpToPage(2);
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomButtonIntro extends StatelessWidget {
  final String text;
  final Function() onTap;
  const CustomButtonIntro({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppSize(context).smallText1,
                color: AppColors.blackColor2,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
