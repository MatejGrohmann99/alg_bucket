import 'package:equatable/equatable.dart';

import '../config/constants.dart';

typedef CSE = CubeStateEntity;

class CubeStateEntity {
  final List<List<List<int>>> state;

  const CubeStateEntity._internal(this.state);

  const CubeStateEntity() : this._internal(CubeConstants.solvedState);

  Map<String, dynamic> toMap() {
    return {
      'state': state,
    };
  }

  factory CubeStateEntity.fromMap(Map<String, dynamic> map) {
    return CubeStateEntity._internal(map['state']);
  }

  CubeStateEntity copyWith({
    List<List<List<int>>>? state,
  }) {
    return CubeStateEntity._internal(
      state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [state];
}
