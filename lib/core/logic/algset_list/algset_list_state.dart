part of 'algset_list_bloc.dart';

sealed class AlgsetListState extends Equatable {
  const AlgsetListState();

  @override
  List<Object?> get props => [];
}

class AlgsetListStateInitial extends AlgsetListState {
  const AlgsetListStateInitial();
}

class AlgsetListStateLoading extends AlgsetListState {
  const AlgsetListStateLoading();
}

class AlgsetListStateLoaded extends AlgsetListState {
  const AlgsetListStateLoaded({required this.algsetList});

  final List<Algset> algsetList;

  List<Algset> get algsetsWithoutParent => algsetList.where((t) => t.parentId == null).toList();

  List<Algset> subAlgsets(String algsetId) => algsetList.where((t) => t.parentId == algsetId).toList();

  @override
  List<Object?> get props => [algsetList];
}

class AlgsetListStateError extends AlgsetListState {
  const AlgsetListStateError();
}
