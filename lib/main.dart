// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/Business/LanguageProvider/l10n_provider.dart';
import 'package:flutter_template/Data/Constant/theme/dark_theme.dart';
import 'package:flutter_template/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_template/Data/Helper/cache_helper.dart';
import 'package:flutter_template/Data/Constant/app_constant.dart';
import 'package:flutter_template/Data/Constant/theme/light_theme.dart';
import 'package:flutter_template/Business/AppProvider/app_provider.dart';
import 'package:flutter_template/Presentation/SplashScreen/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  // Todo : That's To All Method Use Await
  WidgetsFlutterBinding.ensureInitialized();
  // Todo : That's To Local Storage
  await CacheHelper.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(),
        ),
      ],
      builder: (c, w) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isWeb = kIsWeb;
  // Todo : Final Availabel
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _streamSubscription;
  // Todo : Connectivity Variable
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  // Todo : Init Connectivity Function
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  // Todo : Update Connection Status Function
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  void initState() {
    log( 'Is App Open In Web ? ' +isWeb.toString());
    // Todo : Init Connectivity Function
    initConnectivity();
    // Todo : Update Connection Status Function
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  @override
  void dispose() {
    // Todo : Dispose Stream Subscription
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Todo : Check Network
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.connectivityResult = _connectivityResult;
    // Todo : Get Language App
    // LanguageProvider langProvider = Provider.of<LanguageProvider>(context);
    LanguageProvider language = Provider.of<LanguageProvider>(context);
    language.lang = CacheHelper.getData(key: CacheHelper.lang);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstans.appName,
        locale: language.lang != null
            ? Locale(language.lang!, '')
            : const Locale('en', ''),
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        theme: lightThemes,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen());
  }
}
