import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/app/app.bottomsheets.dart';
import 'package:music_app/app/app.dialogs.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_font_provider.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final fontNotifier = FontNotifier();
  await fontNotifier.loadFont();

  setupDialogUi();
  setupBottomSheetUi();
  requestPermission();
  runApp(ChangeNotifierProvider(
      create: (_) => fontNotifier, child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final font = Provider.of<FontNotifier>(context).currentFont;

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: ksAppName,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
          ],
          theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: kcBlack),
            fontFamily: font,
            textTheme: const TextTheme(
              titleLarge: TextStyle(fontWeight: FontWeight.w700),
              bodyMedium: TextStyle(fontWeight: FontWeight.w500),
              bodyLarge: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        );
      },
    );
  }
}

Future<void> requestPermission() async {
  await Permission.storage.request(); // for older Android
  await Permission.audio.request(); // for Android 13+
}
