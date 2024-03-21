import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:product_app/bloc/auth/auth_bloc.dart';
import 'package:product_app/firebase_options.dart';
import 'package:product_app/hive/hive.dart';
import 'package:product_app/view/auth/pin_login_view.dart';
import 'package:product_app/view/auth/signup_view.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:product_app/view/home/home_view.dart';

import 'package:product_app/view/splash/splash_view.dart';

import 'bloc/splash/splash_bloc.dart';
import 'view/auth/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get the directory to store Hive data
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  // Initialize Hive with the path
  Hive.init(appDocumentDirectory.path);
  hivebox = await Hive.openBox('testBox');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreenView(),
          '/login': (context) => const LoginView(),
          '/signup': (context) => const SingupView(),
          '/pin': (context) => const PinLoginView(),
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}
