import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/amplifyconfiguration.dart';
import 'package:music_app/app/app.bottomsheets.dart';
import 'package:music_app/app/app.dialogs.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/bottom_bar/bottom_bar_view.dart';
import 'package:music_app/ui/views/email/presentation/email_view.dart';
import 'package:music_app/ui/views/password/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await SharedPreferencesHelper.getLoginStatus();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details); // Print error in release too
  };

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
  ], child: MainApp(isLoggedIn: isLoggedIn)));
}

class MainApp extends StatefulWidget {
  final bool isLoggedIn;

  const MainApp({super.key, required this.isLoggedIn});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: ksAppName,
            debugShowCheckedModeBanner: false,
            home: widget.isLoggedIn ? const BottomBarView() : const EmailView(),
            initialRoute: Routes.startupView,
            theme: ThemeData(
              appBarTheme:
                  const AppBarTheme(backgroundColor: kcBackgroundColor),
              fontFamily: 'Inter',
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 45.sp,
                  // color: AppColorsSchemes.titleColor
                ),
                titleMedium: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  // color: AppColorsSchemes.titleColor
                ),
              ),
            ),
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
            navigatorObservers: [
              StackedService.routeObserver,
            ],
          );
        });
  }
}
