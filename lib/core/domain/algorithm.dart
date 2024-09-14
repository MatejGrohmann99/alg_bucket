import 'package:equatable/equatable.dart';
import 'package:cube_core/cube_core.dart';

class Algorithm extends Equatable {
  const Algorithm({
    required this.name,
    required this.setup,
    this.main,
    this.alts,
    this.description,
  });


  final String name;

  final String? description;

  final List<CM> setup;

  final List<CM>? main;

  final List<List<CM>>? alts;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'setup': setup.toAlgString(),
      'main': main?.toAlgString(),
      'alts': alts?.toAlgStringList(),
    };
  }

  static Algorithm? fromJson(dynamic json) {
    final name = json['name'] as String;
    final description = json['description'] as String?;
    final setup = AlgService().getAlgorithmFromString(json['setup'] as String);
    final main = json['main'] != null ? AlgService().getAlgorithmFromString(json['main'] as String) : null;
    final alts = json['alts'] != null
        ? (json['alts'] as List<dynamic>).map((e) => AlgService().getAlgorithmFromString(e as String)).toList()
        : null;

    return Algorithm(
      name: name,
      description: description,
      setup: setup,
      main: main,
      alts: alts,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        main,
        alts,
      ];
}
