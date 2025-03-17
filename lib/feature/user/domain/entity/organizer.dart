import 'package:maelstorm/feature/user/domain/entity/base_user.dart';

class Organizer extends BaseUser {
  ///SIRET numper
  final String siret;

  ///Littel description of organizer
  final String description;

  ///Instagram link
  final String? instagramLink;

  ///Youtube link
  final String? youtubeLink;

  ///Facebook link
  final String? facebookLink;

  ///List id of organizer favort places
  final List<String> favoritePlaceList;

  const Organizer({
    required super.id,
    required this.siret,
    required super.name,
    required super.email,
    required super.password,
    required super.image,
    required this.description,
    required this.instagramLink,
    required this.youtubeLink,
    required this.facebookLink,
    required this.favoritePlaceList,
  });

  @override
  List<Object?> get props => [siret, ...super.props, favoritePlaceList];
}
