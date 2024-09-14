
import 'package:cube_core/cube_core.dart';
import 'package:ditredi/ditredi.dart';
import 'package:vector_math/vector_math_64.dart';

import 'piece_3d.dart';


class Cube3d extends Group3D {
  final CubeStateEntity state;

  final Map<String, Set<int>>? ignore;

  final double pieceSize;

  Cube3d(this.state, {this.pieceSize = 0.1, this.ignore})
      : super(
          _generateCubies(
            state.state,
            pieceSize,
            ignore ?? {},
          ),
        );

  static List<Model3D<Model3D>> _generateCubies(List<List<List<int>>> state, double pieceSize, Map<String, Set<int>> ignores) {
    final s = pieceSize;
    final ss = pieceSize + pieceSize;
    return [
      // UFL
      Piece3d(
        s,
        Vector3(0, ss, 0),
        uColor: state[0][2][0],
        fColor: state[1][0][0],
        lColor: state[4][0][2],
        ignores: ignores,
      ),
      // UF
      Piece3d(
        s,
        Vector3(s, ss, 0),
        uColor: state[0][2][1],
        fColor: state[1][0][1],
        ignores: ignores,
      ),
      // UFR
      Piece3d(
        s,
        Vector3(ss, ss, 0),
        uColor: state[0][2][2],
        fColor: state[1][0][2],
        rColor: state[2][0][0],
        ignores: ignores,
      ),

      // UL
      Piece3d(
        s,
        Vector3(0, ss, s),
        uColor: state[0][1][0],
        lColor: state[4][0][1],
        ignores: ignores,
      ),

      // U center
      Piece3d(
        s,
        Vector3(s, ss, s),
        uColor: state[0][1][1],
        ignores: ignores,
      ),

      // UR
      Piece3d(
        s,
        Vector3(ss, ss, s),
        uColor: state[0][1][2],
        rColor: state[2][0][1],
        ignores: ignores,
      ),

      // UBL
      Piece3d(
        s,
        Vector3(0, ss, ss),
        uColor: state[0][0][0],
        bColor: state[3][0][2],
        lColor: state[4][0][0],
        ignores: ignores,
      ),

      // UB
      Piece3d(
        s,
        Vector3(s, ss, ss),
        uColor: state[0][0][1],
        bColor: state[3][0][1],
        ignores: ignores,
      ),

      // UBR
      Piece3d(
        s,
        Vector3(ss, ss, ss),
        uColor: state[0][0][2],
        bColor: state[3][0][0],
        rColor: state[2][0][2],
        ignores: ignores,
      ),

      // FL
      Piece3d(
        s,
        Vector3(0, s, 0),
        fColor: state[1][1][0],
        lColor: state[4][1][2],
        ignores: ignores,
      ),

      // F center
      Piece3d(
        s,
        Vector3(s, s, 0),
        fColor: state[1][1][1],
        ignores: ignores,
      ),

      // FR
      Piece3d(
        s,
        Vector3(ss, s, 0),
        fColor: state[1][1][2],
        rColor: state[2][1][0],
        ignores: ignores,
      ),

      // R center
      Piece3d(
        s,
        Vector3(ss, s, s),
        rColor: state[2][1][1],
        ignores: ignores,
      ),

      // L center
      Piece3d(
        s,
        Vector3(0, s, s),
        lColor: state[4][1][1],
        ignores: ignores,
      ),

      // BL
      Piece3d(
        s,
        Vector3(0, s, ss),
        bColor: state[3][1][2],
        lColor: state[4][1][0],
        ignores: ignores,
      ),

      // B center
      Piece3d(
        s,
        Vector3(s, s, ss),
        bColor: state[3][1][1],
        ignores: ignores,
      ),

      // BR
      Piece3d(
        s,
        Vector3(ss, s, ss),
        bColor: state[3][1][0],
        rColor: state[2][1][2],
        ignores: ignores,
      ),

      // DFL
      Piece3d(
        s,
        Vector3(0, 0, 0),
        dColor: state[5][0][0],
        fColor: state[1][2][0],
        lColor: state[4][2][2],
        ignores: ignores,
      ),
      // DF
      Piece3d(
        s,
        Vector3(s, 0, 0),
        dColor: state[5][0][1],
        fColor: state[1][2][1],
        ignores: ignores,
      ),
      // DFR
      Piece3d(
        s,
        Vector3(ss, 0, 0),
        dColor: state[5][0][2],
        fColor: state[1][2][2],
        rColor: state[2][2][0],
        ignores: ignores,
      ),

      // DL
      Piece3d(
        s,
        Vector3(0, 0, s),
        dColor: state[5][1][0],
        lColor: state[4][2][1],
        ignores: ignores,
      ),

      // D center
      Piece3d(
        s,
        Vector3(s, 0, s),
        dColor: state[5][1][1],
        ignores: ignores,
      ),

      // DR
      Piece3d(
        s,
        Vector3(ss, 0, s),
        dColor: state[5][1][2],
        rColor: state[2][2][1],
        ignores: ignores,
      ),

      // DBL
      Piece3d(
        s,
        Vector3(0, 0, ss),
        dColor: state[5][2][0],
        bColor: state[3][2][2],
        lColor: state[4][2][0],
        ignores: ignores,
      ),

      // DB
      Piece3d(
        s,
        Vector3(s, 0, ss),
        dColor: state[5][2][1],
        bColor: state[3][2][1],
        ignores: ignores,
      ),

      // DBR
      Piece3d(
        s,
        Vector3(ss, 0, ss),
        dColor: state[5][2][2],
        bColor: state[3][2][0],
        rColor: state[2][2][2],
        ignores: ignores,
      ),
    ];
  }
}
