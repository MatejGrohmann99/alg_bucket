part of 'algset_list_bloc.dart';

sealed class AlgsetListEvent extends Equatable {
  const AlgsetListEvent();

  @override
  List<Object?> get props => [];
}

class AlgsetListEventLoad extends AlgsetListEvent {
  const AlgsetListEventLoad();
}

class AlgsetListEventAdd extends AlgsetListEvent {
  const AlgsetListEventAdd({required this.algset});

  final Algset algset;

  @override
  List<Object?> get props => [algset];
}

class AlgsetListEventUpdate extends AlgsetListEvent {
  const AlgsetListEventUpdate({required this.algset});

  final Algset algset;

  @override
  List<Object?> get props => [algset];
}