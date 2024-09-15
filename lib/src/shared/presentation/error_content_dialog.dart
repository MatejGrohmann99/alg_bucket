import 'package:fluent_ui/fluent_ui.dart';

class ErrorContentDialog extends StatelessWidget {
  const ErrorContentDialog({
    required this.title,
    required this.error,
    required this.stackTrace,
    super.key,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required dynamic error,
    required StackTrace stackTrace,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => ErrorContentDialog(
        stackTrace: stackTrace,
        error: error,
        title: title,
      ),
    );
  }

  final String title;
  final dynamic error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${error.runtimeType}: ${error.toString()}'),
          if (stackTrace.toString().trim() case final stack when stack.isNotEmpty) Text(stack),
        ],
      ),
      actions: [
        FilledButton(
          child: const Text('Ok'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
