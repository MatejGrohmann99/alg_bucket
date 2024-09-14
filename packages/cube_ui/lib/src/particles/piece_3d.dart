import 'package:ditredi/ditredi.dart';
import 'package:vector_math/vector_math_64.dart';
import '../cube_color_config.dart';
import 'plane_3d.dart';

class Piece3d extends Group3D {
  final double size;
  final Vector3 position;

  final int? fColor;
  final int? bColor;
  final int? rColor;
  final int? lColor;
  final int? uColor;
  final int? dColor;

  Map<String, Set<int>>? ignores;

  Piece3d(
    this.size,
    this.position, {
    this.ignores,
    this.fColor = -1,
    this.bColor = -1,
    this.rColor = -1,
    this.lColor = -1,
    this.uColor = -1,
    this.dColor = -1,
  }) : super(
          _generatePlanes(size, position, fColor, bColor, rColor, lColor, uColor, dColor, ignores ?? {}),
        );

  static List<Model3D<Model3D>> _generatePlanes(double size, Vector3 position, int? fColor, int? bColor, int? rColor,
      int? lColor, int? uColor, int? dColor, Map<String, Set<int>> map) {
    final cInt = [fColor, bColor, rColor, lColor, uColor, dColor];
    cInt.sort();
    final colorIst = cInt.toSet();
    colorIst.removeWhere((element) => element == -1);
    final colorHash = colorIst.fold('', (String prev, element) => prev + element.toString());

    final contains = map.containsKey(colorHash);

    bool ic(int? c) => contains && map[colorHash]!.contains(c);

    return [
      Plane3d(
        size / 2,
        Axis3D.x,
        true,
        Vector3(position.x - size / 2, position.y, position.z),
        color: ic(lColor) ? CubeColor.grey : CubeColor.fromIndex(lColor),
      ),

      Plane3d(
        size / 2,
        Axis3D.x,
        false,
        Vector3(position.x + size / 2, position.y, position.z),
        color: ic(rColor) ? CubeColor.grey : CubeColor.fromIndex(rColor),
      ),

      /////
      Plane3d(
        size / 2,
        Axis3D.y,
        false,
        Vector3(position.x, position.y + size / 2, position.z),
        color: ic(uColor) ? CubeColor.grey : CubeColor.fromIndex(uColor),
      ),

      Plane3d(
        size / 2,
        Axis3D.y,
        true,
        Vector3(position.x, position.y - size / 2, position.z),
        color: ic(dColor) ? CubeColor.grey : CubeColor.fromIndex(dColor),
      ),

      Plane3d(
        size / 2,
        Axis3D.z,
        false,
        Vector3(position.x, position.y, position.z - size / 2),
        color: ic(fColor) ? CubeColor.grey : CubeColor.fromIndex(fColor),
      ),

      Plane3d(
        size / 2,
        Axis3D.z,
        true,
        Vector3(position.x, position.y, position.z + size / 2),
        color: ic(bColor) ? CubeColor.grey : CubeColor.fromIndex(bColor),
      ),
    ];
  }
}
