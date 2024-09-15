import 'dart:convert';
import 'dart:developer';

import 'package:alg_bucket/src/migration/domain/migration_data.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MigrationButton extends StatefulWidget {
  const MigrationButton({required this.onAlgsetAdded, super.key});

  final void Function(MigrationData data) onAlgsetAdded;

  @override
  State<MigrationButton> createState() => _MigrationButtonState();
}

class _MigrationButtonState extends State<MigrationButton> {
  final FocusNode focusNode = FocusNode();
  final newAlgKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');
  final controller = TextEditingController();

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(
            controller: controller,
            focusNode: focusNode,
            placeholder: 'Name of the algset',
          ),
          FilledButton(
            child: const Text('Upload file'),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowMultiple: false,
                allowedExtensions: ['csv'],
              );

              if (result != null) {
                PlatformFile file = result.files.first;

                // Read the file content
                String csvString = utf8.decode(file.bytes!);

                List<List<dynamic>> rows = const CsvToListConverter().convert(csvString);

                List<String> data = <String>[];

                for (var row in rows) {
                  for (var cell in row) {
                    final value = cell.toString();

                    if (value.isNotEmpty) {
                      data.add(value);
                    }
                  }
                }

                for (var item in data) {
                  log(item);
                }
              }
            },
          ),
        ],
      ),
      header: const Text('Migrate your algset from csv!'),
    );
  }
}
