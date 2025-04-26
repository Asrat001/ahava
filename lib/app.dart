import 'package:ahava/app_data.dart';
import 'package:ahava/screens/home_screen.dart';
import 'package:ahava/screens/main_screen.dart';
import 'package:ahava/state/content_provider.dart';
import 'package:ahava/state/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/configs/them_data.dart';

class App extends StatelessWidget {
  const App({super.key, required this.data});

  final AppData data;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        title: 'Discovery App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}