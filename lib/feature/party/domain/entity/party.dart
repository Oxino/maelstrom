import 'package:equatable/equatable.dart';
import 'package:maelstorm/feature/party/domain/entity/tag.dart';

class Party extends Equatable {
  final String id;
  final String organizerId;
  final String placeId;
  final String placeAddress;
  final String title;
  final String description;
  final String image;
  final DateTime start;
  final DateTime end;
  final List<Tag> tags;
  final List<String> interestedPeoples;
  final List<String> bookingPeoples;

  const Party(
      {required this.id,
      required this.organizerId,
      required this.placeId,
      required this.placeAddress,
      required this.title,
      required this.description,
      required this.image,
      required this.start,
      required this.end,
      required this.tags,
      required this.interestedPeoples,
      required this.bookingPeoples});

  @override
  List<Object?> get props => [
        id,
        organizerId,
        placeId,
        placeAddress,
        title,
        description,
        image,
        start,
        end,
        tags,
        interestedPeoples,
        bookingPeoples
      ];
}
