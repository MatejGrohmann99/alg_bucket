import 'package:cube_core/cube_core.dart';
import 'package:cube_ui/src/particles/cube_3d.dart';

import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';

class CubeWidget extends StatefulWidget {
  const CubeWidget({
    this.textEditingController,
    this.ignoreLL = false,
    super.key,
  });

  final TextEditingController? textEditingController;

  final bool ignoreLL;

  @override
  State<CubeWidget> createState() => _CubeWidgetState();
}

class _CubeWidgetState extends State<CubeWidget> {
  late final DiTreDiController _controller;
  final List<Group3D> _cubies = [];

  late final ignoreMap = {
    '014': {0, 1, 4},
    '01':  {1},
    '012': {0, 1, 2},
    '02': {2},
    '023': {0, 2, 3},
    '03': {3},
    '034': {0, 3, 4},
    '04': {4},
  };

  @override
  void initState() {
    super.initState();
    _controller = DiTreDiController(
      lightStrength: 1,
      ambientLightStrength: 1,
      rotationX: -30,
    );

    if (widget.textEditingController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.textEditingController!.addListener(_onTextControllerChanged);
      });
    }

    _cubies.add(Cube3d(const CubeStateEntity(), ignore: ignoreMap));
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_onTextControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.rotationX = _controller.rotationX + 30;
        setState(() {});
      },
      child: SizedBox(
        width: 300,
        height: 300,
        child: DiTreDiDraggable(
          scaleEnabled: false,
          rotationEnabled: true,
          controller: _controller,
          child: DiTreDi(
            controller: _controller,
            figures: _cubies,
          ),
        ),
      ),
    );
  }

  void _onTextControllerChanged() {
    final alg = AlgService().getAlgorithmFromString(widget.textEditingController!.text);

    final newState = MoveService().executeAlgorithm(const CubeStateEntity(), AlgService().invertAlgorithm(alg));
    _cubies.clear();
    _cubies.add(
      Cube3d(newState, ignore: ignoreMap),
    );
    setState(() {});
  }
}
