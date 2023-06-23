import 'package:flutter/material.dart';
import 'package:flutter_template/Business/LanguageProvider/l10n_provider.dart';
import 'package:flutter_template/Data/Helper/cache_helper.dart';
import 'package:flutter_template/Presentation/Components/custom_appbar.dart';

import 'package:flutter_template/Presentation/Home/Screens/order_screen.dart';
import 'package:flutter_template/Presentation/Home/Screens/home_screen.dart';
import 'package:flutter_template/Presentation/Home/Screens/profile_screen.dart';
import 'package:flutter_template/Presentation/Home/Screens/cart_screen.dart';
import 'package:flutter_template/l10n/l10n.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> screen = const [
    OncePage(),
    SecondPage(),
    ThredPage(),
    FifthPage(),
  ];


  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.cart,
      AppLocalizations.of(context)!.order,
      AppLocalizations.of(context)!.profile,
    ];
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar.appBar(
          context: context,
          title: titles[currentIndex],
          actions: [
            IconButton(
              onPressed: () {
                if (languageProvider.lang == 'en') {
                  languageProvider.setLocal(locale: L10n.all.last);
                  CacheHelper.saveData(
                      key: CacheHelper.lang, value: L10n.all.last.languageCode);
                } else {
                  languageProvider.setLocal(locale: L10n.all.first);

                  CacheHelper.saveData(
                      key: CacheHelper.lang,
                      value: L10n.all.first.languageCode);
                }
              },
              icon: const Icon(Icons.language),
            ),
          ]),
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_bag_outlined),
              label: AppLocalizations.of(context)!.cart),
          BottomNavigationBarItem(
              icon: const Icon(Icons.turned_in_not_outlined),
              label: AppLocalizations.of(context)!.order),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person_outlined),
              label: AppLocalizations.of(context)!.profile),
        ],
        onTap: (int index) {
          changeBottomIndex(index);
        },
      ),
    );
  }

  void changeBottomIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
