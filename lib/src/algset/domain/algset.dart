import 'dart:convert';

import 'package:collection/collection.dart';
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
    this.useFirstCaseAsDisplayImage = true,
  });

  final String id;

  final String? parentId;

  final List<CM> imageSetup;

  final Map<String, List<int>>? ignoreConfig;

  final String name;

  final List<Algorithm> cases;

  final bool useFirstCaseAsDisplayImage;

  Algset addCase(Algorithm alg) {
    return Algset(
      id: id,
      name: name,
      cases: [...cases, alg],
      imageSetup: imageSetup,
      ignoreConfig: ignoreConfig,
      parentId: parentId,
      useFirstCaseAsDisplayImage: useFirstCaseAsDisplayImage,
    );
  }

  Algset editAlgorithm(Algorithm alg, int index) {
    final newCases = cases.mapIndexed((i, e) => i == index ? alg : e).toList();
    return Algset(
      id: id,
      name: name,
      cases: newCases,
      imageSetup: imageSetup,
      ignoreConfig: ignoreConfig,
      parentId: parentId,
      useFirstCaseAsDisplayImage: useFirstCaseAsDisplayImage,
    );
  }

  Algset removeCase(int index) {
    final newCases = cases.whereIndexed((i, _) => i != index).toList();
    return Algset(
      id: id,
      name: name,
      cases: newCases,
      imageSetup: imageSetup,
      ignoreConfig: ignoreConfig,
      parentId: parentId,
      useFirstCaseAsDisplayImage: useFirstCaseAsDisplayImage,
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
      'useFirstCaseAsDisplayImage': useFirstCaseAsDisplayImage,
    };
  }

  static Algset fromJson(String id, dynamic json) {
    final useFirstCaseAsDisplayImage = json['useFirstCaseAsDisplayImage'] as bool? ?? true;

    final name = json['name'] as String;
    final cases = (json['cases'] as List<dynamic>?)?.map((e) => Algorithm.fromJson(e)).nonNulls.toList();
    final ignoreConfig = jsonDecode(json['ignore']) as Map?;
    var ignoreConfigMap = <String, List<int>>{};
    final parentId = json['parentId'] as String?;
    final imageSetup = json['imageSetup'] != null && json['imageSetup'] is String && json['imageSetup'].isNotEmpty
        ? AlgService().getAlgorithmFromString(json['imageSetup'] as String)
        : (useFirstCaseAsDisplayImage ? cases?.firstOrNull?.setup ?? <CM>[] : <CM>[]);

    if (ignoreConfig != null) {
      ignoreConfigMap = ignoreConfig.map((key, value) {
        return MapEntry(key as String, (value as List<dynamic>).map((e) => e as int).toList());
      });
    }

    return Algset(
      id: id,
      name: name,
      cases: cases ?? [],
      imageSetup: imageSetup,
      ignoreConfig: ignoreConfigMap,
      parentId: parentId,
      useFirstCaseAsDisplayImage: useFirstCaseAsDisplayImage,
    );
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'Algset{id: $id, name: $name, cases: $cases, ignoreConfig: $ignoreConfig, parentId: $parentId}';
  }
}
