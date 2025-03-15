import 'package:maelstorm/feature/user/domain/entity/base_user.dart';

class Organizer extends BaseUser {
  ///Littel description of organizer
  final String description;

  ///List id of organizer favort places
  final List<String> favoritePlaceList;

  const Organizer(
      {required super.id,
      required super.name,
      required super.email,
      required super.password,
      required super.image,
      required this.description,
      required this.favoritePlaceList});

  @override
  List<Object?> get props => [...super.props, favoritePlaceList];
}
