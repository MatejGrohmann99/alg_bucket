import 'dart:developer';

import '../domain/cube_move_enum.dart';

class AlgService {
  static final _instance = AlgService._internal();

  factory AlgService() => _instance;

  AlgService._internal();

  List<CM> getAlgorithmFromString(String s) {
    final source = s.replaceAll(RegExp(r'[\[\](){\}]'), '');

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

  String convertAlgorithmToString(List<CM> alg) {
    var as = '';
    for (var i = 0; i < alg.length; i++) {
      as += _moveToString(alg[i]);
      if (i != alg.length - 1) {
        as += ' ';
      }
    }
    return as;
  }

  List<CM> invertAlgorithm(List<CM> algorithm) {
    final inverseAlgorithm = <CM>[];
    for (final move in algorithm) {
      final inverseMove = _getInverseMove(move);
      inverseAlgorithm.insert(0, inverseMove);
    }
    return inverseAlgorithm;
  }

  String _moveToString(CM m, {bool isWideMoveWide = false}) {
    return switch (m) {
      CM.U => 'U',
      CM.U2 => 'U2',
      CM.Ui => 'U\'',
      CM.D => 'D',
      CM.D2 => 'D2',
      CM.Di => 'D\'',
      CM.L => 'L',
      CM.L2 => 'L2',
      CM.Li => 'L\'',
      CM.R => 'R',
      CM.R2 => 'R2',
      CM.Ri => 'R\'',
      CM.F => 'F',
      CM.F2 => 'F2',
      CM.Fi => 'F\'',
      CM.B => 'B',
      CM.B2 => 'B2',
      CM.Bi => 'B\'',
      CM.Uw => isWideMoveWide ? 'Uw' : 'u',
      CM.Uw2 => isWideMoveWide ? 'Uw2' : 'u2',
      CM.Uwi => isWideMoveWide ?  'Uw\'' : 'u\'',
      CM.Dw =>  isWideMoveWide ?  'Dw' : 'd',
      CM.Dw2 => isWideMoveWide ?  'Dw2' : 'd2',
      CM.Dwi => isWideMoveWide ?  'Dw\'' : 'd\'',
      CM.Lw => isWideMoveWide ?  'Lw' : 'l',
      CM.Lw2 => isWideMoveWide ?  'Lw2' : 'l2',
      CM.Lwi => isWideMoveWide ?  'Lw\'' : 'l\'',
      CM.Rw => isWideMoveWide? 'Rw' : 'r',
      CM.Rw2 => isWideMoveWide ?  'Rw2' : 'r2',
      CM.Rwi => isWideMoveWide ?  'Rw\'' : 'r\'',
      CM.Fw => isWideMoveWide ?  'Fw' : 'f',
      CM.Fw2 => isWideMoveWide ?  'Fw2' : 'f2',
      CM.Fwi => isWideMoveWide ?  'Fw\'' : 'f\'',
      CM.Bw => isWideMoveWide ?  'Bw' : 'b',
      CM.Bw2 => isWideMoveWide ?  'Bw2' : 'b2',
      CM.Bwi => isWideMoveWide ?  'Bw\'' : 'b\'',
      CM.M => 'M',
      CM.M2 => 'M2',
      CM.Mi => 'M\'',
      CM.E => 'E',
      CM.E2 => 'E2',
      CM.Ei => 'E\'',
      CM.S => 'S',
      CM.S2 => 'S2',
      CM.Si => 'S\'',
      CM.X => 'x',
      CM.X2 => 'x2',
      CM.Xi => 'x\'',
      CM.Y => 'y',
      CM.Y2 => 'y2',
      CM.Yi => 'y\'',
      CM.Z => 'z',
      CM.Z2 => 'z2',
      CM.Zi => 'z\'',
    };
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
      'R2' || 'R2\'' => CM.R2,
      'R\'' || 'R’' => CM.Ri,
      'F' => CM.F,
      'F2' || 'F2\'' => CM.F2,
      'F\'' || 'F’' => CM.Fi,
      'B' => CM.B,
      'B2' || 'B2\'' => CM.B2,
      'B\'' || 'B’' => CM.Bi,
      'u' || 'Uw' => CM.Uw,
      'u2' || 'Uw2' || 'U2\'' || 'Uw2\'' => CM.Uw2,
      'u\'' || 'u’' || 'Uw\'' || 'Uw’' => CM.Uwi,
      'd' || 'Dw' => CM.Dw,
      'd2' || 'Dw2' || 'Dw2\'' || 'd2\'' => CM.Dw2,
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
