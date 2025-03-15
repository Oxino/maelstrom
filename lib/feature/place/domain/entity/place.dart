import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final String name;
  final String address;

  const Place({required this.id, required this.name, required this.address});

  @override
  List<Object?> get props => [id, name, address];
}
