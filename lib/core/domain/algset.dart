import 'dart:convert';

import 'package:cube_core/cube_core.dart';
import 'package:equatable/equatable.dart';

import 'algorithm.dart';

class Algset extends Equatable {
  const Algset({
    required this.id,
    required this.name,
    required this.cases,
    this.imageSetup = const [],
    this.ignoreConfig,
    this.parentId,
  });

  final String id;

  final String? parentId;

  final List<CM> imageSetup;

  final Map<String, List<int>>? ignoreConfig;

  final String name;

  final List<Algorithm> cases;

  Algset addCase(Algorithm alg) {
    return Algset(
      id: id,
      name: name,
      cases: [...cases, alg],
      imageSetup: imageSetup,
      ignoreConfig: ignoreConfig,
      parentId: parentId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageSetup': imageSetup.toAlgString(),
      'cases': cases.map((e) => e.toJson()).toList(),
      'ignore': jsonEncode(ignoreConfig),
      'parentId': parentId,
    };
  }

  static Algset? fromJson(String id, dynamic json) {
    final name = json['name'] as String;
    final cases = (json['cases'] as List<dynamic>?)?.map((e) => Algorithm.fromJson(e)).nonNulls.toList();
    final ignoreConfig = jsonDecode(json['ignore']) as Map?;
    var ignoreConfigMap = <String, List<int>>{};
    final parentId = json['parentId'] as String?;
    final imageSetup =
        json['imageSetup'] != null ? AlgService().getAlgorithmFromString(json['imageSetup'] as String) : null;

    if (ignoreConfig != null) {
      ignoreConfigMap = ignoreConfig.map((key, value) {
        return MapEntry(key as String, (value as List<dynamic>).map((e) => e as int).toList());
      });
    }

    return Algset(
      id: id,
      name: name,
      cases: cases ?? [],
      imageSetup: imageSetup ?? [],
      ignoreConfig: ignoreConfigMap,
      parentId: parentId,
    );
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'Algset{id: $id, name: $name, cases: $cases, ignoreConfig: $ignoreConfig, parentId: $parentId}';
  }
}
