import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kniffel/domain/general/highscore_storage.dart';
import 'package:kniffel/main.dart';
import 'package:kniffel/presentation/player/choose_numberof_players.dart';
import 'package:kniffel/presentation/general/highscore.dart';
import 'package:kniffel/presentation/general/rules.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MyHomePage(title: '', child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const ChooseNumberOfPlayers(),
          path: '/',
        ),
        GoRoute(
          path: '/highscore',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) =>
              HighscoreScreen(storage: ImplementedHighscoreStorage()),
        ),
        GoRoute(
          path: '/rules',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const RulesScreen(),
        ),
      ],
    )
  ],
);
