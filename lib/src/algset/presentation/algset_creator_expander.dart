import 'package:fluent_ui/fluent_ui.dart';

class AlgsetCreatorExpander extends StatefulWidget {
  const AlgsetCreatorExpander({
    super.key,
    required this.onAlgsetAdded,
  });

  final void Function(String) onAlgsetAdded;

  @override
  State<AlgsetCreatorExpander> createState() => _AlgsetCreatorTabState();
}

class _AlgsetCreatorTabState extends State<AlgsetCreatorExpander> {
  final newAlgKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Expander(
      onStateChanged: (isExpanded) {
        if (!isExpanded) {
          controller.clear();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            focusNode.requestFocus();
          });
        }
      },
      key: newAlgKey,
      header: const Text('Add new algset'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(
            focusNode: focusNode,
            controller: controller,
            placeholder: 'Enter algset name',
          ),
          FilledButton(
            child: const Text('Add'),
            onPressed: () {
              final name = controller.text;
              controller.clear();
              newAlgKey.currentState?.setState(
                () {
                  newAlgKey.currentState?.isExpanded = false;
                },
              );
              widget.onAlgsetAdded(name);
            },
          ),
        ],
      ),
    );
  }
}
