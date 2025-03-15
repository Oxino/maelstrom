import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:maelstorm/feature/user/presentation/page/login_page.dart';
import 'package:maelstorm/page/home_page.dart';

///{@category Constant}

///Enum all page in app
enum AppPage {
  home(name: 'Accueil', path: '/home', child: HomePage()),
  findParty(name: 'Accueil', path: '/party/find', child: SizedBox()),
  party(name: 'Accueil', path: '/party', child: SizedBox()),
  profil(name: 'Accueil', path: '/user/profile', child: SizedBox()),
  createParty(name: 'Accueil', path: '/party/create', child: SizedBox()),
  map(name: 'Accueil', path: '/map', child: SizedBox()),
  updateProfile(name: 'Accueil', path: '/profile/update', child: SizedBox()),
  settings(name: 'Accueil', path: '/settings', child: SizedBox()),
  organizer(name: 'Accueil', path: '/organiser', child: SizedBox()),
  upadateOrganizer(name: 'Accueil', path: '/organiser/update', child: SizedBox()),
  update(name: 'Mise à jour', path: '/update', child: Center(child: Text('Mise à jour'))),
  erp(name: 'Articles ERP', path: '/erp', child: Center(child: Text('Articles ERP'))),
  provider(
      name: 'Articles Fournisseurs',
      path: '/provider',
      child: Center(child: Text('Articles Fournisseurs'))),
  newProduct(name: 'Nouvel article', path: '/new', child: Center(child: Text('Nouvel article'))),
  automation(name: 'Automation', path: '/automation', child: Center(child: Text('Automation'))),
  login(name: 'Connexion', path: '/login', isTemplate: false, child: LoginPage()),
  forgotPassword(
      name: 'Mot de passe oublié',
      path: '/password/forgot_password',
      isTemplate: false,
      child: Center(child: Text('Mot de passe oublié'))),
  codePassword(
      name: 'Code du Mot de passe',
      path: '/password/get_code',
      isTemplate: false,
      child: Center(child: Text('Renseignez le code'))),
  updatePassword(
      name: 'Mettre a jour le mot de passe',
      path: '/password/update_by_code',
      isTemplate: false,
      child: Center(child: Text('Mettre a jour le mot de passe')));

  ///Name of page
  final String name;

  ///Path of page
  final String path;

  ///Define if page have base template
  final bool isTemplate;

  ///Widget page
  final Widget child;
  const AppPage(
      {required this.name, required this.path, this.isTemplate = true, required this.child});

  static AppPage? byPath(String? path) {
    if (path == null) {
      log.e('AppPage > byPath > Path empty');
      return null;
    }

    AppPage? appPage = AppPage.values.firstWhereOrNull((AppPage appPage) => appPage.path == path);

    if (appPage == null) {
      log.e('AppPage > byPath > Unknown path');
      return null;
    }

    return appPage;
  }

  String getPath(Map<String, String> params) {
    String finalPath = path;
    params.forEach((key, value) => finalPath = finalPath.replaceAll(':$key', value));
    return finalPath;
  }

  void go(
    BuildContext context, {
    String param = "",
    replace = false,
    Object? extra,
  }) {
    String route = "$path$param";

    GoRouter.of(context).go(route, extra: extra);
  }
}
