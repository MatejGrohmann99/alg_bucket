import 'package:alg_bucket/src/algset/domain/algorithm.dart';
import 'package:alg_bucket/src/algset/presentation/bloc/algset_list_bloc.dart';
import 'package:cube_core/cube_core.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cube_ui/cube_ui.dart';

import '../../migration/presentation/migratation_button.dart';
import '../domain/algset.dart';

class HomePageContentView extends StatefulWidget {
  const HomePageContentView({super.key});

  @override
  State<HomePageContentView> createState() => _HomePageContentViewState();
}

class _HomePageContentViewState extends State<HomePageContentView> {
  late final AlgsetListBloc _algsetListBloc = AlgsetListBloc();

  final _items = <BreadcrumbItem<int>>[];

  @override
  void initState() {
    super.initState();
    _algsetListBloc.add(const AlgsetListEventLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlgsetListBloc>.value(
      value: _algsetListBloc,
      child: BlocBuilder<AlgsetListBloc, AlgsetListState>(
        builder: (context, state) {
          switch (state) {
            case AlgsetListStateInitial():
            case AlgsetListStateLoading():
              return const Center(
                child: ProgressRing(),
              );
            case AlgsetListStateLoaded():
              if (_items.isEmpty) {
                return ListView.builder(
                  itemCount: state.algsetsWithoutParent.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.algsetsWithoutParent.length) {
                      return Column(
                        children: [
                          AlgsetCreatorTab(
                            onAlgsetAdded: (name) {
                              context.read<AlgsetListBloc>().add(
                                    AlgsetListEventAdd(
                                      algset: Algset(
                                        id: '',
                                        name: name,
                                        cases: const [],
                                        imageSetup: const [],
                                        ignoreConfig: const {},
                                        parentId: '',
                                      ),
                                    ),
                                  );
                            },
                          ),
                          MigrationButton(
                            onAlgsetAdded: (data) {},
                          ),
                        ],
                      );
                    }

                    final algset = state.algsetsWithoutParent[index];
                    return ListTile(
                      leading: CubeImageWidget(
                        setup: algset.imageSetup,
                        ignoreMap: algset.ignoreConfig,
                      ),
                      title: Text(algset.name),
                      onPressed: () {
                        setState(
                          () {
                            _items.add(
                              BreadcrumbItem(
                                label: Text(
                                  algset.name,
                                  style: FluentTheme.of(context).typography.subtitle,
                                ),
                                value: state.algsetList.indexOf(algset),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(FluentIcons.back),
                          onPressed: () {
                            setState(
                              () {
                                final index = _items.length - 1;
                                _items.removeRange(index, _items.length);
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: BreadcrumbBar<int>(
                            items: _items,
                            onItemPressed: (item) {
                              setState(
                                () {
                                  final index = _items.indexOf(item);
                                  _items.removeRange(index + 1, _items.length);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (state.subAlgsets(state.algsetList[_items.last.value].id) case final List<Algset> sublist
                        when sublist.isNotEmpty)
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sublist.length,
                          itemBuilder: (context, index) {
                            final algset = sublist[index];
                            return SizedBox(
                              width: 300,
                              height: 300,
                              child: ListTile(
                                leading: CubeImageWidget(
                                  setup: algset.imageSetup,
                                  ignoreMap: algset.ignoreConfig,
                                ),
                                title: Text(algset.name),
                                onPressed: () {
                                  setState(
                                    () {
                                      _items.add(
                                        BreadcrumbItem(
                                          label: Text(
                                            algset.name,
                                            style: FluentTheme.of(context).typography.subtitle,
                                          ),
                                          value: state.algsetList.indexOf(algset),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.algsetList[_items.last.value].cases.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'This set has ${state.getSelectedAlgCount(state.algsetList[_items.last.value].id)} algorithms'),
                                AlgCreatorTab(
                                  ignoreMap: state.algsetList[_items.last.value].ignoreConfig,
                                  onAlgorithmAdded: (algorithm) {
                                    context.read<AlgsetListBloc>().add(
                                          AlgsetListEventUpdate(
                                            algset: state.algsetList[_items.last.value].addCase(algorithm),
                                          ),
                                        );
                                  },
                                ),
                                AlgsetCreatorTab(
                                  onAlgsetAdded: (name) {
                                    context.read<AlgsetListBloc>().add(
                                          AlgsetListEventAdd(
                                            algset: Algset(
                                              id: '',
                                              name: name,
                                              cases: const [],
                                              imageSetup: const [],
                                              ignoreConfig: state.algsetList[_items.last.value].ignoreConfig,
                                              parentId: state.algsetList[_items.last.value].id,
                                            ),
                                          ),
                                        );
                                  },
                                ),
                              ],
                            );
                          }

                          final singleCase = state.algsetList[_items.last.value].cases[index - 1];
                          return ListTile(
                            leading: Text(
                              '${index.toString()}.',
                              style: FluentTheme.of(context).typography.title,
                            ),
                            trailing: CubeImageWidget(
                              setup: singleCase.setup,
                              ignoreMap: state.algsetList[_items.last.value].ignoreConfig,
                            ),
                            title: Text(
                              singleCase.name,
                              style: FluentTheme.of(context).typography.bodyStrong,
                            ),
                            subtitle: Text(
                              'Main: ${singleCase.main?.toAlgString()} \nSetup: ${singleCase.setup.toAlgString()}',
                              maxLines: 2,
                              style: FluentTheme.of(context).typography.bodyLarge,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );

            case AlgsetListStateError():
              return const Center(
                child: Text('Error'),
              );
          }
        },
      ),
    );
  }
}

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

class AlgsetCreatorTab extends StatefulWidget {
  const AlgsetCreatorTab({super.key, required this.onAlgsetAdded});

  final void Function(String) onAlgsetAdded;

  @override
  State<AlgsetCreatorTab> createState() => _AlgsetCreatorTabState();
}

class _AlgsetCreatorTabState extends State<AlgsetCreatorTab> {
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
