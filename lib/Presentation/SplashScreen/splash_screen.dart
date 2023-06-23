import 'package:flutter/material.dart';
import 'package:flutter_template/Data/Constant/Image/app_image.dart';
import 'package:flutter_template/Data/Functions/app_size.dart';
import 'package:flutter_template/Data/Functions/navigation.dart';
import 'package:flutter_template/Presentation/Introdation/introdaction_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigatorToFirstPage();
    super.initState();
  }

  navigatorToFirstPage() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      downToTop(const IntodactionLayout()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: AppSize(context).width * 0.6,
          width: AppSize(context).width * 0.6,
          child: Image(
            image: AppImage.logo,
          ),
        ),
      ),
    );
  }
}
