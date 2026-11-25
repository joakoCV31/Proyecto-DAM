import 'package:descuidau/constants.dart';
import 'package:descuidau/widgets/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale('es')],
      title: 'descuidaU',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: AuthWrapper(),
    );
  }
}

