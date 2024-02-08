import 'package:flutter/material.dart';
import 'package:messanger/core/theme/light_theme.dart';
import 'package:messanger/features/messanger/di/injection_container.dart';
import 'package:messanger/features/messanger/presentation/page/app_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: AppPage(),
    );
  }
}
