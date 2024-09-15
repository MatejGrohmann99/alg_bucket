import 'package:cube_core/cube_core.dart';
import 'package:equatable/equatable.dart';

class MigrationData extends Equatable {
  const MigrationData({
    required this.algsetName,
    required this.migratedAlgs,
  });

  final String algsetName;

  final List<MigratedAlg> migratedAlgs;

  @override
  List<Object?> get props => [algsetName, migratedAlgs];
}

class MigratedAlg extends Equatable {
  const MigratedAlg({
    required this.content,
    required this.setup,
    required this.representation,
  });

  final List<CM> content;

  final List<CM> setup;

  final CSE representation;

  @override
  List<Object?> get props => [content, setup, representation];
}
