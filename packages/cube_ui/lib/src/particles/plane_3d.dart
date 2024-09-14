import 'dart:ui';

import 'package:ditredi/ditredi.dart';
import 'package:vector_math/vector_math_64.dart';

import '../cube_color_config.dart';

/// A plane with border
class Plane3d extends Group3D {
  final Axis3D axis;

  final bool negative;

  final double size;

  final Vector3 position;

  final Color? color;

  final double borderWidth;

  final Color borderColor;

  Plane3d(
      this.size,
      this.axis,
      this.negative,
      this.position, {
        this.color = CubeColor.red,
        this.borderWidth = 2,
        this.borderColor = CubeColor.black,
      }) : super(_getFigures(
    size,
    axis,
    negative,
    position,
    color,
    borderWidth,
    borderColor,
  ));

  /// Copies the plane.
  Plane3d copyWith({
    Axis3D? axis,
    bool? negative,
    double? size,
    Vector3? position,
    Color? color,
  }) {
    return Plane3d(
      size ?? this.size,
      axis ?? this.axis,
      negative ?? this.negative,
      position ?? this.position,
      color: color ?? this.color,
    );
  }

  @override
  Plane3d clone() {
    return Plane3d(size, axis, negative, position, color: color);
  }

  @override
  int get hashCode => Object.hash(axis, negative, size, position, color);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Plane3d &&
            runtimeType == other.runtimeType &&
            other.axis == axis &&
            other.negative == negative &&
            other.size == size &&
            other.position == position &&
            other.color == color;
  }
}

List<Model3D> _getFigures(
    double size, Axis3D axis, bool negative, Vector3 position, Color? color, double borderWidth, Color borderColor) {
  switch (axis) {
    case Axis3D.x:
      if (negative) {
        return [
          Face3D(
            Triangle.points(
                Vector3(position.x, position.y + size, position.z + size),
                Vector3(position.x, position.y + -size, position.z + size),
                Vector3(position.x, position.y + -size, position.z + -size)),
            color: color,
          ),
          Face3D(
            Triangle.points(
                Vector3(position.x, position.y + -size, position.z + -size),
                Vector3(position.x, position.y + size, position.z + -size),
                Vector3(position.x, position.y + size, position.z + size)),
            color: color,
          ),
          Line3D(
            Vector3(position.x, position.y + size, position.z + size),
            Vector3(position.x, position.y + -size, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x, position.y + -size, position.z + -size),
            Vector3(position.x, position.y + size, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x, position.y + size, position.z + size),
            Vector3(position.x, position.y + size, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x, position.y - size, position.z + -size),
            Vector3(position.x, position.y - size, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
        ];
      } else {
        return [
          Face3D(
            Triangle.points(
                Vector3(position.x, position.y + -size, position.z + -size),
                Vector3(position.x, position.y + -size, position.z + size),
                Vector3(position.x, position.y + size, position.z + size)),
            color: color,
          ),
          Face3D(
            Triangle.points(
                Vector3(position.x, position.y + size, position.z + size),
                Vector3(position.x, position.y + size, position.z + -size),
                Vector3(position.x, position.y + -size, position.z + -size)),
            color: color,
          ),
          Line3D(
            Vector3(position.x, position.y + -size, position.z + -size),
            Vector3(position.x, position.y + -size, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x, position.y + size, position.z + size),
            Vector3(position.x, position.y + size, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x, position.y + -size, position.z + -size),
            Vector3(position.x, position.y + size, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x, position.y + size, position.z + size),
            Vector3(position.x, position.y + -size, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
        ];
      }
    case Axis3D.y:
      if (negative) {
        return [
          Face3D(
            Triangle.points(
                Vector3(position.x + -size, position.y, position.z + -size),
                Vector3(position.x + -size, position.y, position.z + size),
                Vector3(position.x + size, position.y, position.z + size)),
            color: color,
          ),
          Face3D(
            Triangle.points(
                Vector3(position.x + size, position.y, position.z + size),
                Vector3(position.x + size, position.y, position.z + -size),
                Vector3(position.x + -size, position.y, position.z + -size)),
            color: color,
          ),
          Line3D(
            Vector3(position.x + -size, position.y, position.z + -size),
            Vector3(position.x + -size, position.y, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + size, position.y, position.z + size),
            Vector3(position.x + size, position.y, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + -size, position.y, position.z + -size),
            Vector3(position.x + size, position.y, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + size, position.y, position.z + size),
            Vector3(position.x + -size, position.y, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
        ];
      } else {
        return [
          Face3D(
            Triangle.points(
                Vector3(position.x + size, position.y, position.z + size),
                Vector3(position.x + -size, position.y, position.z + size),
                Vector3(position.x + -size, position.y, position.z + -size)),
            color: color,
          ),
          Face3D(
            Triangle.points(
                Vector3(position.x + -size, position.y, position.z + -size),
                Vector3(position.x + size, position.y, position.z + -size),
                Vector3(position.x + size, position.y, position.z + size)),
            color: color,
          ),
          Line3D(
            Vector3(position.x + size, position.y, position.z + size),
            Vector3(position.x + -size, position.y, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + -size, position.y, position.z + -size),
            Vector3(position.x + size, position.y, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + size, position.y, position.z + size),
            Vector3(position.x + size, position.y, position.z + -size),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + -size, position.y, position.z + -size),
            Vector3(position.x + -size, position.y, position.z + size),
            color: borderColor,
            width: borderWidth,
          ),
        ];
      }
    case Axis3D.z:
      if (negative) {
        return [
          Face3D(
            Triangle.points(
                Vector3(position.x + -size, position.y + -size, position.z),
                Vector3(position.x + -size, position.y + size, position.z),
                Vector3(position.x + size, position.y + size, position.z)),
            color: color,
          ),
          Face3D(
            Triangle.points(
                Vector3(position.x + size, position.y + size, position.z),
                Vector3(position.x + size, position.y + -size, position.z),
                Vector3(position.x + -size, position.y + -size, position.z)),
            color: color,
          ),
          Line3D(
            Vector3(position.x + -size, position.y + -size, position.z),
            Vector3(position.x + -size, position.y + size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + size, position.y + size, position.z),
            Vector3(position.x + size, position.y + -size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + -size, position.y + -size, position.z),
            Vector3(position.x + size, position.y + -size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + size, position.y + size, position.z),
            Vector3(position.x + -size, position.y + size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
        ];
      } else {
        return [
          Face3D(
            Triangle.points(
                Vector3(position.x + size, position.y + size, position.z),
                Vector3(position.x + -size, position.y + size, position.z),
                Vector3(position.x + -size, position.y + -size, position.z)),
            color: color,
          ),
          Face3D(
            Triangle.points(
                Vector3(position.x + -size, position.y + -size, position.z),
                Vector3(position.x + size, position.y + -size, position.z),
                Vector3(position.x + size, position.y + size, position.z)),
            color: color,
          ),
          Line3D(
            Vector3(position.x + size, position.y + size, position.z),
            Vector3(position.x + -size, position.y + size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + -size, position.y + -size, position.z),
            Vector3(position.x + size, position.y + -size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + size, position.y + size, position.z),
            Vector3(position.x + size, position.y + -size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
          Line3D(
            Vector3(position.x + -size, position.y + -size, position.z),
            Vector3(position.x + -size, position.y + size, position.z),
            color: borderColor,
            width: borderWidth,
          ),
        ];
      }
  }
}
