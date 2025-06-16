import 'package:flutter/material.dart';
import 'package:music_app/amplifyconfiguration.dart';
import 'package:music_app/app/app.bottomsheets.dart';
import 'package:music_app/app/app.dialogs.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/email/email_view.dart';
import 'package:music_app/ui/views/password/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
  ], child: const MainApp()));
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
    return MaterialApp(
      title: ksAppName,
      debugShowCheckedModeBanner: false,
      home: const EmailView(),
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: ksAppName,
//       debugShowCheckedModeBanner: false,
//       initialRoute: Routes.startupView,
//       onGenerateRoute: StackedRouter().onGenerateRoute,
//       navigatorKey: StackedService.navigatorKey,
//       navigatorObservers: [
//         StackedService.routeObserver,
//       ],
//     );
//   }
// }
