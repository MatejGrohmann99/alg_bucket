import 'package:alg_bucket/src/algset/domain/algset.dart';
import 'package:cube_ui/cube_ui.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AlgsetListTile extends StatelessWidget {
  const AlgsetListTile({
    required this.algset,
    required this.onPressed,
    super.key,
  });

  final Algset algset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: ListTile(
        leading: CubeImageWidget(
          setup: algset.imageSetup,
          ignoreMap: algset.ignoreConfig,
        ),
        title: Text(algset.name),
        onPressed: onPressed,
      ),
    );
  }
}
