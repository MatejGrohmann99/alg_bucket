import 'package:alg_bucket/src/algset/domain/algset_api_interface.dart';
import 'package:alg_bucket/src/shared/domain/fake_response.dart';
import 'package:cube_core/cube_core.dart';
import 'package:dartz/dartz.dart';

import '../../shared/domain/maybe.dart';
import '../domain/algorithm.dart';
import '../domain/algset.dart';

class AlgsetFakeApi implements AlgsetApiInterface {
  final _algsets = [
    const Algset(
      id: '1',
      name: 'Mock Algset',
      cases: [],
      imageSetup: [
        CM.R,
        CM.U,
        CM.Ri,
        CM.Ui,
      ],
    ),
    const Algset(
      id: '1a',
      parentId: '1',
      name: 'Mock sub algset',
      cases: [
        Algorithm(
          name: 'Mock Algorithm',
          setup: [
            CM.R,
            CM.U,
            CM.Ri,
            CM.Ui,
          ],
          main: [
            CM.U,
            CM.R,
            CM.Ui,
            CM.Ri,
          ],
          alts: [
            [
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
            ],
            [
              CM.U,
              CM.R,
              CM.Ui,
              CM.Ri,
            ],
          ],
        ),
      ],
      imageSetup: [
        CM.R,
        CM.U,
        CM.Ri,
        CM.Ui,
      ],
    ),
    const Algset(
      id: '2',
      name: 'Mock Algset 2',
      cases: [],
      imageSetup: [
        CM.Ri,
        CM.F,
        CM.R,
        CM.Fi,
      ],
    ),
    const Algset(
      id: '3',
      name: 'Mock Algset 3',
      cases: [],
      imageSetup: [
        CM.M,
        CM.U,
        CM.Mi,
        CM.Ui,
      ],
    ),
  ];

  @override
  Future<Maybe<List<Algset>>> getUserAlgsets() {
    return FakeResponse.success(_algsets);
  }

  @override
  Future<Maybe<Unit>> addAlgset(Algset algset) {
    _algsets.add(algset);
    return FakeResponse.success(unit);
  }

  @override
  Future<Maybe<Unit>> updateAlgset(Algset algset) {
    final index = _algsets.indexWhere((element) => element.id == algset.id);
    _algsets[index] = algset;

    return FakeResponse.success(unit);
  }
}
