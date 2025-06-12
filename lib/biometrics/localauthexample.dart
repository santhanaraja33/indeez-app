// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';
//
// class LocalAuthExample extends StatefulWidget {
//   @override
//   _LocalAuthExampleState createState() => _LocalAuthExampleState();
// }
//
// class _LocalAuthExampleState extends State<LocalAuthExample> {
//   final LocalAuthentication auth = LocalAuthentication();
//   String _message = "Not Authenticated";
//
//   Future<void> _authenticate() async {
//     bool isAuthenticated = false;
//
//     try {
//       bool canCheckBiometrics = await auth.canCheckBiometrics;
//       bool isDeviceSupported = await auth.isDeviceSupported();
//
//       if (!canCheckBiometrics || !isDeviceSupported) {
//         setState(() {
//           _message = "Biometric authentication not available.";
//         });
//         return;
//       }
//
//       isAuthenticated = await auth.authenticate(
//         localizedReason: 'Please authenticate to continue',
//         options: const AuthenticationOptions(
//           biometricOnly: true,
//           stickyAuth: true,
//           useErrorDialogs: true,
//         ),
//       );
//     } catch (e) {
//       setState(() {
//         _message = "Error: $e";
//       });
//     }
//
//     setState(() {
//       _message = isAuthenticated ? "Authenticated" : "Authentication Failed";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Local Auth")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(_message),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _authenticate,
//               child: Text("Authenticate"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
