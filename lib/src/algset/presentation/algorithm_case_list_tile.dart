import 'package:alg_bucket/src/algset/domain/algorithm.dart';
import 'package:cube_core/cube_core.dart';
import 'package:cube_ui/cube_ui.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AlgorithmCaseListTile extends StatelessWidget {
  const AlgorithmCaseListTile({
    required this.index,
    required this.alg,
    required this.ignoreMap,
    super.key,
  });

  final int index;
  final Algorithm alg;
  final IgnoreMap? ignoreMap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${index.toString()}.',
        style: FluentTheme.of(context).typography.title,
      ),
      trailing: CubeImageWidget(
        setup: alg.setup,
        ignoreMap: ignoreMap,
      ),
      title: Text(
        alg.name,
        style: FluentTheme.of(context).typography.bodyStrong,
      ),
      subtitle: Text(
        'Main: ${alg.main?.toAlgString()} \nSetup: ${alg.setup.toAlgString()}',
        maxLines: 2,
        style: FluentTheme.of(context).typography.bodyLarge,
      ),
    );
  }
}
