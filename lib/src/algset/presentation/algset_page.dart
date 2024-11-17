import 'package:alg_bucket/src/algset/presentation/algorithm_case_list_tile.dart';
import 'package:alg_bucket/src/algset/presentation/algset_creator_expander.dart';
import 'package:alg_bucket/src/algset/presentation/algset_list_tile.dart';
import 'package:alg_bucket/src/algset/presentation/bloc/algset_list_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cube_ui/cube_ui.dart';

import '../../migration/presentation/migratation_button.dart';
import '../domain/algorithm.dart';
import '../domain/algset.dart';
import 'algorithm_creator_expander.dart';

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
              void onAlgsetAddedHandler(String name) {
                context.read<AlgsetListBloc>().add(
                      AlgsetListEventAdd(
                        algset: Algset(
                          id: '',
                          name: name,
                          cases: const [],
                          imageSetup: const [],
                          ignoreConfig: _items.isNotEmpty ? state.algsetList[_items.last.value].ignoreConfig : null,
                          parentId: _items.isNotEmpty ? state.algsetList[_items.last.value].id : null,
                        ),
                      ),
                    );
              }

              void onAlgorithmAddedHandler(Algorithm algorithm) {
                context.read<AlgsetListBloc>().add(
                      AlgsetListEventUpdate(
                        algset: state.algsetList[_items.last.value].addCase(algorithm),
                      ),
                    );
              }

              if (_items.isEmpty) {
                return ListView.builder(
                  itemCount: state.algsetsWithoutParent.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.algsetsWithoutParent.length) {
                      return Column(
                        children: [
                          AlgsetCreatorExpander(onAlgsetAdded: onAlgsetAddedHandler),
                          MigrationButton(onAlgsetAdded: (data) {}),
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
                            return AlgsetListTile(
                              algset: algset,
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
                                  onAlgorithmAdded: onAlgorithmAddedHandler,
                                ),
                                AlgsetCreatorExpander(
                                  onAlgsetAdded: onAlgsetAddedHandler,
                                ),
                              ],
                            );
                          }

                          final singleCase = state.algsetList[_items.last.value].cases[index - 1];
                          final ignoreMap = state.algsetList[_items.last.value].ignoreConfig;
                          return AlgorithmCaseListTile(
                            index: index,
                            alg: singleCase,
                            ignoreMap: ignoreMap,
                            onEdit: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const ContentDialog(
                                    title: Text('Edit algorithm'),
                                    content: Text('Nemáte někdo voheň do píči?'),
                                  );
                                },
                              );
                            },
                            onDelete: () {
                              final algset = state.algsetList[_items.last.value];
                              final removedAlg = algset.removeCase(index - 1);
                              context.read<AlgsetListBloc>().add(
                                    AlgsetListEventUpdate(
                                      algset: removedAlg,
                                    ),
                                  );
                            },
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
