import 'package:maelstorm/feature/user/domain/entity/base_user.dart';

class User extends BaseUser {
  final String firstName;
  final String lastName;

  ///Date of birth
  final DateTime birthDate;

  ///List id of user favort organizer
  final List<String> favoriteuserList;

  ///List id of organizer favort places
  final List<String> favoritePlaceList;

  const User(
      {required super.id,
      required super.email,
      required super.password,
      required super.image,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.favoriteuserList,
      required this.favoritePlaceList})
      : super(name: firstName);

  @override
  List<Object?> get props =>
      [...super.props, firstName, lastName, birthDate, favoritePlaceList, favoritePlaceList];
}
