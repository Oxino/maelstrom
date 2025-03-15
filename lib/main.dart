import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maelstorm/core/config/routes/router.dart';
import 'package:maelstorm/feature/alert/presentation/bloc/alert_bloc.dart';
import 'package:maelstorm/feature/user/presentation/bloc/user_bloc.dart';
import 'package:maelstorm/global.dart';
import 'package:maelstorm/injection_container.dart';

Future<void> main() async {
  await InjectionContainer(getIt: getIt).initialize();
  runApp(const EDIProductApp());
}

class EDIProductApp extends StatelessWidget {
  const EDIProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EDI Produit',
      theme: ThemeData(),
      routerConfig: getIt<RouterClient>().router,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<UserBloc>()),
          BlocProvider(create: (_) => getIt<AlertBloc>()),
        ],
        child: Scaffold(body: child),
      ),
    );
  }
}
