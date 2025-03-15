import 'package:equatable/equatable.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';

class SetStorage extends Equatable {
  final StorageValue key;
  final String value;

  const SetStorage({required this.key, required this.value});

  @override
  List<Object?> get props => [key, value];
}
