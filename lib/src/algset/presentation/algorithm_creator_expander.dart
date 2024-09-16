
import 'package:cube_core/cube_core.dart';
import 'package:cube_ui/cube_ui.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../domain/algorithm.dart';

class AlgCreatorTab extends StatefulWidget {
  const AlgCreatorTab({super.key, required this.onAlgorithmAdded, required this.ignoreMap});

  final Map<String, List<int>>? ignoreMap;

  final void Function(Algorithm) onAlgorithmAdded;

  @override
  State<AlgCreatorTab> createState() => _AlgCreatorTabState();
}

class _AlgCreatorTabState extends State<AlgCreatorTab> {
  final newAlgKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');
  final controller = TextEditingController();
  final nameController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Expander(
      key: newAlgKey,
      header: const Text('Add new algorithm'),
      onStateChanged: (isExpanded) {
        if (!isExpanded) {
          nameController.clear();
          controller.clear();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            focusNode.requestFocus();
          });
        }
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CubeWidget(
            textEditingController: controller,
            ignoreMap: widget.ignoreMap,
          ),
          TextBox(
            focusNode: focusNode,
            controller: nameController,
            placeholder: 'Enter name',
            textInputAction: TextInputAction.next,
          ),
          TextBox(
            controller: controller,
            placeholder: 'Enter algorithm',
          ),
          FilledButton(
            child: const Text('Add'),
            onPressed: () {
              final algorithm = Algorithm(
                name: nameController.text,
                setup: AlgService().invertAlgorithm(AlgService().getAlgorithmFromString(controller.text)),
                main: AlgService().getAlgorithmFromString(controller.text),
              );
              controller.clear();

              newAlgKey.currentState?.setState(
                    () {
                  newAlgKey.currentState?.isExpanded = false;
                },
              );
              widget.onAlgorithmAdded(algorithm);
            },
          ),
        ],
      ),
    );
  }
}

