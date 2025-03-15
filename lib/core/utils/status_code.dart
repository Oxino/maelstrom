import 'package:collection/collection.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:retrofit/dio.dart';

enum StatusCode {
  success(code: 200, message: "Requete est un succes"),
  badRequest(code: 400, message: "Requete invalide"),
  unauthorized(code: 401, message: "Vous etes restez innactif trop longtemps."),
  invalidToken(code: 402, message: "Le token est invalid"),
  forbidden(code: 403, message: "Accés refusé"),
  notFound(code: 404, message: "Informations incorrectes"),
  wrongMethod(code: 405, message: "La méthode non autorisé"),
  conflict(code: 409, message: "Un conflit a été détecté"),
  retry(code: 449, message: "Reéssayer avec de nouveaux paramètres"),
  passwordsNotMatch(code: 461, message: "Les mot de passes ne sont as les mêmes"),
  invalidPassword(code: 462, message: "Le mot de passe n'est pas conforme aux exigences"),
  userNotValidated(code: 463, message: "L'utilisateur n'a pas été verifié"),
  userChangePassword(code: 464, message: "L'utilisateur doit changer de mot dde passe"),
  unknownSSO(code: 465, message: "Serveur SSO inconu"),
  userTemporaryLocked(
      code: 466, message: "Le compte est temporairement bloqué. Réessayez dans 2 minutes."),
  desactivatedUser(code: 467, message: "Ce compte a été désactivé"),
  invalidCode(code: 468, message: "Le code est invalide"),
  unknownError(code: 500, message: "Erreur serveur. Veuillez contacter un administrateur."),
  fillAllField(code: 1000, message: "Renseignez tous les champs");

  final int code;
  final String message;
  const StatusCode({required this.code, required this.message});

  factory StatusCode.byInt(int? code) {
    if (code == null) {
      log.d('StatusCode > getByCode > Empty code');
      return StatusCode.unknownError;
    }

    StatusCode? statusCode =
        StatusCode.values.firstWhereOrNull((StatusCode statusCode) => statusCode.code == code);

    if (statusCode == null) {
      log.e('StatusCode > getByCode > Error code: $code is not referanced in StatusCode');
      return StatusCode.unknownError;
    }

    return statusCode;
  }

  static bool isSuccess(HttpResponse response) =>
      response.response.statusCode == StatusCode.success.code;

  @override
  String toString() => "StatusCode(code: $code, message: $message)";
}
