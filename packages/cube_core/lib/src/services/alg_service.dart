import 'dart:developer';

import '../domain/cube_move_enum.dart';

class AlgService {
  static final _instance = AlgService._internal();

  factory AlgService() => _instance;
  AlgService._internal();

  List<CM> getAlgorithmFromString(String source) {
    final alg = <CM>[];
    for (final i in source.split(' ')) {
      if (i.isEmpty) {
        continue;
      }

      try {
        final move = _tryParseMove(i);
        if (move == null) {
          throw Exception('Move $i was not parsed');
        }
        alg.add(move);
      } catch (e, s) {
        log(
          e.toString(),
          name: 'getAlgorithmFromString',
          stackTrace: s,
        );
        continue;
      }
    }

    return alg;
  }

  List<CM> invertAlgorithm(List<CM> algorithm) {
    final inverseAlgorithm = <CM>[];
    for (final move in algorithm) {
      final inverseMove = _getInverseMove(move);
      inverseAlgorithm.insert(0, inverseMove);
    }
    return inverseAlgorithm;
  }

  CM? _tryParseMove(String s) {
    return switch (s) {
      'U' => CM.U,
      'U2' => CM.U2,
      'U\'' || 'U’' => CM.Ui,
      'D' => CM.D,
      'D2' => CM.D2,
      'D\'' || 'D’' => CM.Di,
      'L' => CM.L,
      'L2' => CM.L2,
      'L\'' || 'L’' => CM.Li,
      'R' => CM.R,
      'R2' => CM.R2,
      'R\'' || 'R’' => CM.Ri,
      'F' => CM.F,
      'F2' => CM.F2,
      'F\'' || 'F’' => CM.Fi,
      'B' => CM.B,
      'B2' => CM.B2,
      'B\'' || 'B’' => CM.Bi,
      'u' || 'Uw' => CM.Uw,
      'u2' || 'Uw2' => CM.Uw2,
      'u\'' || 'u’' || 'Uw\'' || 'Uw’' => CM.Uwi,
      'd' || 'Dw' => CM.Dw,
      'd2' || 'Dw2' => CM.Dw2,
      'd\'' || 'd’' || 'Dw\'' || 'Dw’' => CM.Dwi,
      'l' || 'Lw' => CM.Lw,
      'l2' || 'Lw2' => CM.Lw2,
      'l\'' || 'l’' || 'Lw\'' || 'Lw’' => CM.Lwi,
      'r' || 'Rw' => CM.Rw,
      'r2' || 'Rw2' => CM.Rw2,
      'r\'' || 'r’' || 'Rw\'' || 'Rw’' => CM.Rwi,
      'f' || 'Fw' => CM.Fw,
      'f2' || 'Fw2' => CM.Fw2,
      'f\'' || 'f’' || 'Fw\'' || 'Fw’' => CM.Fwi,
      'b' || 'Bw' => CM.Bw,
      'b2' || 'Bw2' => CM.Bw2,
      'b\'' || 'b’' || 'Bw\'' || 'Bw’' => CM.Bwi,
      'M' || 'Mw' => CM.M,
      'M2' || 'Mw2' => CM.M2,
      'M\'' || 'M’' || 'Mw\'' || 'Mw’' => CM.Mi,
      'E' || 'Ew' => CM.E,
      'E2' || 'Ew2' => CM.E2,
      'E\'' || 'E’' || 'Ew\'' || 'Ew’' => CM.Ei,
      'S' || 'Sw' => CM.S,
      'S2' || 'Sw2' => CM.S2,
      'S\'' || 'S’' || 'Sw\'' || 'Sw’' => CM.Si,
      'x' => CM.X,
      'x2' => CM.X2,
      'x\'' || 'x’' => CM.Xi,
      'y' => CM.Y,
      'y2' => CM.Y2,
      'y\'' || 'y’' => CM.Yi,
      'z' => CM.Z,
      'z2' => CM.Z2,
      'z\'' || 'z’' => CM.Zi,
      _ => null,
    };
  }

  CM _getInverseMove(CM m) {
    return switch (m) {
      CM.U => CM.Ui,
      CM.U2 => CM.U2,
      CM.Ui => CM.U,
      CM.D => CM.Di,
      CM.D2 => CM.D2,
      CM.Di => CM.D,
      CM.L => CM.Li,
      CM.L2 => CM.L2,
      CM.Li => CM.L,
      CM.R => CM.Ri,
      CM.R2 => CM.R2,
      CM.Ri => CM.R,
      CM.F => CM.Fi,
      CM.F2 => CM.F2,
      CM.Fi => CM.F,
      CM.B => CM.Bi,
      CM.B2 => CM.B2,
      CM.Bi => CM.B,
      CM.Uw => CM.Uwi,
      CM.Uw2 => CM.Uw2,
      CM.Uwi => CM.Uw,
      CM.Dw => CM.Dwi,
      CM.Dw2 => CM.Dw2,
      CM.Dwi => CM.Dw,
      CM.Lw => CM.Lwi,
      CM.Lw2 => CM.Lw2,
      CM.Lwi => CM.Lw,
      CM.Rw => CM.Rwi,
      CM.Rw2 => CM.Rw2,
      CM.Rwi => CM.Rw,
      CM.Fw => CM.Fwi,
      CM.Fw2 => CM.Fw2,
      CM.Fwi => CM.Fw,
      CM.Bw => CM.Bwi,
      CM.Bw2 => CM.Bw2,
      CM.Bwi => CM.Bw,
      CM.M => CM.Mi,
      CM.M2 => CM.M2,
      CM.Mi => CM.M,
      CM.E => CM.Ei,
      CM.E2 => CM.E2,
      CM.Ei => CM.E,
      CM.S => CM.Si,
      CM.S2 => CM.S2,
      CM.Si => CM.S,
      CM.X => CM.Xi,
      CM.X2 => CM.X2,
      CM.Xi => CM.X,
      CM.Y => CM.Yi,
      CM.Y2 => CM.Y2,
      CM.Yi => CM.Y,
      CM.Z => CM.Zi,
      CM.Z2 => CM.Z2,
      CM.Zi => CM.Z,
    };
  }
}