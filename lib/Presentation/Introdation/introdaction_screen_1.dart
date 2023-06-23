import 'package:flutter/material.dart';
import 'package:flutter_template/Data/Functions/app_size.dart';
import 'package:flutter_template/Presentation/Components/custom_cach_network_image.dart';

class IntrodactionScreen1 extends StatelessWidget {
  const IntrodactionScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSize(context).height * 0.02,
              horizontal: AppSize(context).width * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize(context).height * 0.4,
                child: const CustomCachNetworkImage(
                  image:
                      'https://wpblog.zyro.com/cdn-cgi/image/w=1200,q=85/wp-content/uploads/2020/03/what-makes-a-good-logo.png',
                ),
              ),
              SizedBox(height: AppSize(context).height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSize(context).height * 0.02,
                    horizontal: AppSize(context).width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'First Screen',
                      style: TextStyle(
                        fontSize: AppSize(context).mediumText1,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: AppSize(context).height * 0.07),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Templete App Using For All application we build ',
                          style: TextStyle(
                              fontSize: AppSize(context).mediumText3,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.2,
                              height: 1.5),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
