import 'package:alg_bucket/src/algset/domain/algorithm.dart';
import 'package:cube_core/cube_core.dart';
import 'package:cube_ui/cube_ui.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AlgorithmCaseListTile extends StatelessWidget {
  const AlgorithmCaseListTile({
    required this.index,
    required this.alg,
    required this.ignoreMap,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  final int index;
  final Algorithm alg;
  final IgnoreMap? ignoreMap;

  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${index.toString()}.',
            style: FluentTheme.of(context).typography.title,
          ),
          CubeImageWidget(
            rotateOnClick: true,
            setup: alg.setup,
            ignoreMap: ignoreMap,
          ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            alg.name,
            style: FluentTheme.of(context).typography.bodyStrong,
          ),
          Expanded(
            child: CommandBar(
              mainAxisAlignment: MainAxisAlignment.end,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: "Edit algorithm",
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.edit),
                    label: const Text('Edit'),
                    onPressed: onEdit,
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: "Delete algorithm",
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.delete),
                    label: const Text('Delete'),
                    onPressed: onDelete,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${alg.main?.toAlgString()}',
            style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
          ),
        ],
      ),
    );
  }
}
