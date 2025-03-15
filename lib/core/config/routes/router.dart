import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maelstorm/core/config/routes/app_page.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:maelstorm/feature/user/presentation/bloc/user_bloc.dart';
import 'package:maelstorm/widget/page_template.dart';

///{@category Config}
class RouterClient {
  ///Routeur of all app
  late final GoRouter router;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  RouterClient() {
    router = GoRouter(
        initialLocation: AppPage.login.path,
        navigatorKey: _navigatorKey,
        routes: [
          ShellRoute(
            builder: (context, state, child) => PageTemplate(child: child),
            routes: AppPage.values
                .where((AppPage page) => page.isTemplate)
                .map((AppPage templatePage) => GoRoute(
                      pageBuilder: (context, state) =>
                          NoTransitionPage(key: state.pageKey, child: templatePage.child),
                      path: templatePage.path,
                      name: templatePage.name,
                    ))
                .toList(),
          ),
          ...AppPage.values
              .where((AppPage page) => !page.isTemplate)
              .map((AppPage noTemplatePage) => GoRoute(
                    pageBuilder: (context, state) =>
                        NoTransitionPage(key: state.pageKey, child: noTemplatePage.child),
                    path: noTemplatePage.path,
                    name: noTemplatePage.name,
                  ))
        ],
        redirect: (context, routerState) {
          AppPage? currentPage = AppPage.byPath(routerState.fullPath);

          if (currentPage == null) return null;

          bool isUserLogged = context.read<UserBloc>().state is LoggedUserState;

          if (!currentPage.isTemplate) {
            if (isUserLogged) {
              log.d("GoRouter > redirect > User logged");
              return AppPage.home.path;
            }

            return null;
          }

          String? newPath;

          if (!isUserLogged) {
            log.d("GoRouter > redirect > User not logged");
            newPath = AppPage.login.path;
          }

          return newPath;
        });
  }
}
