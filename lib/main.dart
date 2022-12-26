import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/composite/apphud_product_composite.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_to_video/config_app.dart';
import 'package:music_to_video/project_editor/helpers/editor_cache.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase init
  await Firebase.initializeApp();
  await FlutterFlowTheme.initialize();

  //AppHud init
  await Apphud.start(apiKey: "app_XDNBhgwwi28LccUQQb3jKYoydJHsg3");

  //Firebase crashlytics init
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp());
  setupInjections();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late Stream<MusicToVideoFirebaseUser> userStream;
  MusicToVideoFirebaseUser? initialUser;
  bool displaySplashImage = true;
  bool isLoading = true;
  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    userStream = musicToVideoFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    Future.delayed(
      Duration(seconds: 1),
      () => setState(() => displaySplashImage = false),
    );
    getConfig();
    getAppHudProducts();
    setupAnalytics();
  }

  setupAnalytics(){
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logAppOpen();
  }

  getAppHudProducts() async{
    print('ACTIVE SUB: ${await Apphud.hasActiveSubscription()}');
    List<ApphudProductComposite>? list = await Apphud.products();
    print('APPHUD PRODUCTS: ${await Apphud.products()}');
    if(list != null){
      for(var item in list){
        print('APPHUD ITEM: ${item.skProductWrapper}');
        print('APPHUD ITEM2: ${item.skuDetailsWrapper}');
      }
      sl<ConfigApp>().product = list.first.skProductWrapper;
      sl<ConfigApp>().isSubscribe = await Apphud.hasActiveSubscription();
    }
    setState(() {
      isLoading = false;  
    });
  }

  getConfig() async{
    sl<ConfigApp>().editors = await getEditorModels();
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) =>
      setState(() => _locale = createLocale(language));
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MusicToVideo',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: initialUser == null || displaySplashImage || isLoading
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primaryColor,
                ),
              ),
            )
          : currentUser!.loggedIn
              ? PreviewPageWidget()
              : MainWidget(),
    );
  }
}
