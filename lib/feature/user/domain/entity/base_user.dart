import 'package:equatable/equatable.dart';

abstract class BaseUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String image;

  const BaseUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.image});

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        image,
      ];
}
