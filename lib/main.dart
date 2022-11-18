// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/provider/auth_provider.dart';
import 'package:flutter_fitness_track/provider/discover_routines_provider.dart';
import 'package:flutter_fitness_track/provider/history_provider.dart';
import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:flutter_fitness_track/provider/user_routines_provider.dart';
import 'package:flutter_fitness_track/screen/home/home_screen.dart';
import 'package:flutter_fitness_track/screen/signin/signin.dart';
import 'package:provider/provider.dart';
import 'theme/theme_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => UserRoutinesProvider()),
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
        Provider<DiscoverRoutinesProvider>(
            create: (context) => DiscoverRoutinesProvider()),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider.of<AuthProvider>(context, listen: true).isAuth
          ? const HomeScreen()
          : const SignInScreen(),
      theme: lightTheme,
      // darkTheme: darkTheme,
    );
  }
}
