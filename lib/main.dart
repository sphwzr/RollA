import 'dart:core';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kniffel/navigation.dart';
import 'package:kniffel/presentation/enter_players.dart';
import 'package:provider/provider.dart';

import 'domain/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
      create: (context) => GameModel(),
      child: MaterialApp.router(
        title: 'Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Widget child;
  final String title;

  MyHomePage({super.key, required this.title, required this.child});
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
       bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        unselectedLabelStyle: TextStyle(color:  Theme.of(context).colorScheme.onPrimary),
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        selectedLabelStyle: TextStyle(color:  Theme.of(context).colorScheme.onSecondary) ,
        onTap: (index) {
          switch(index){
            case 0:  
              context.go('/');
              break;
            case 1:  
              context.go('/highscore');
              break;
            default:
              context.go('/rules');
              break;
          }
            _currentIndex = index;
        },
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Highscore'),
          BottomNavigationBarItem(icon: Icon(Icons.rule), label: 'Rules'),
        ],
       ),
      );
  }
}
