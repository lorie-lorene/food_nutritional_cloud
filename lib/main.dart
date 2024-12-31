import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_nutritional_cloud/firebase_options.dart';
import 'package:food_nutritional_cloud/pages/detail/widgets/register.dart';
import 'package:food_nutritional_cloud/pages/home/home.dart';
import 'package:food_nutritional_cloud/pages/home/home.dart';
import 'package:food_nutritional_cloud/pages/home/login_page.dart';
import 'package:food_nutritional_cloud/services/auth/auth_gate.dart';
import 'package:food_nutritional_cloud/services/auth/auth_service.dart';
import 'package:food_nutritional_cloud/services/auth/login_or_register.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(create:(context)=>AuthService(),
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gamestore',
      // home: HomePage(),
      // home: LoginPage(),
      // home: LoginOrRegister(),
      home: AuthGate(),
    );
  }
}