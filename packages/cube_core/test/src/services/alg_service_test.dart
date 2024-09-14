import 'package:cube_core/cube_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgServiceTest:', () {
    final service = AlgService();

    test(
      'Parsing smoke test:',
      () {
        const alg = "F R U R' U' F'";

        final convert = service.getAlgorithmFromString(alg);

        expect(
          convert,
          [CM.F, CM.R, CM.U, CM.Ri, CM.Ui, CM.Fi],
        );

        final back = service.convertAlgorithmToString(convert);

        expect(back, alg);
      },
    );
  });
}
