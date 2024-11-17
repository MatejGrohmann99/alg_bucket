import 'package:cube_core/cube_core.dart';
import 'package:cube_ui/src/particles/cube_3d.dart';

import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';

typedef IgnoreMap = Map<String, List<int>>;

class CubeImageWidget extends StatefulWidget {
  const CubeImageWidget({
    this.setup,
    this.ignoreMap,
    this.rotateOnClick = false,
    this.size = 200,
    super.key,
  });

  final double size;

  final bool rotateOnClick;

  final List<CM>? setup;
  final Map<String, List<int>>? ignoreMap;

  @override
  State<CubeImageWidget> createState() => _CubeImageWidgetState();
}

class _CubeImageWidgetState extends State<CubeImageWidget> {
  late final DiTreDiController _controller;
  final List<Group3D> _cubies = [];

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    _controller = DiTreDiController(
      lightStrength: 1,
      ambientLightStrength: 1,
      rotationX: -30,
    );

    var state = const CubeStateEntity();
    var ignore = <String, Set<int>>{};

    if (widget.setup != null) {
      state = MoveService().executeAlgorithm(state, widget.setup!);
    }

    if (widget.ignoreMap != null) {
      for (var key in widget.ignoreMap!.keys) {
        ignore[key] = widget.ignoreMap![key]!.toSet();
      }
    }

    _cubies.add(
      Cube3d(
        state,
        ignore: ignore,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = !isLoaded
        ? const SizedBox.expand()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: DiTreDi(
                  controller: _controller,
                  figures: _cubies,
                ),
              ),
              if (widget.rotateOnClick && false)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.rotate_left,
                        size: 12,
                      ),
                      onTap: () {
                        _controller.rotationY -= 90;
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.rotate_right,
                        size: 12,
                      ),
                      onTap: () {
                        _controller.rotationY += 90;
                      },
                    ),
                  ],
                ),
            ],
          );
    return content;
  }
}
