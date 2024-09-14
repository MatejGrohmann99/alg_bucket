import 'package:cube_core/cube_core.dart';
import 'package:cube_core/src/config/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const solvedState = CubeStateEntity();
  final transformer = MoveService();
  group(
    'MoveService:',
    () {
      test(
        '[RU] gen smoke test:',
        () {
          var act = transformer.executeAlgorithm(
            solvedState,
            [
              CM.R2,
              CM.U2,
              CM.R2,
              CM.U2,
              CM.R2,
              CM.U2,
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
              CM.R2,
              CM.U2,
              CM.R2,
              CM.U2,
              CM.R2,
              CM.U2,
            ],
          );

          expect(
            act,
            solvedState,
          );
          expect(
            act.state,
            CubeConstants.solvedState,
          );
        },
      );
    },
  );
}
