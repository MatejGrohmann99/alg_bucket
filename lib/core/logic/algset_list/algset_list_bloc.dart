import 'dart:async';

import 'package:alg_bucket/core/service/firebase_storage_service.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/algset.dart';

part 'algset_list_state.dart';

part 'algset_list_event.dart';

class AlgsetListBloc extends Bloc<AlgsetListEvent, AlgsetListState> {
  AlgsetListBloc() : super(const AlgsetListStateInitial()) {
    on<AlgsetListEvent>(_eventHandler, transformer: sequential());
  }

  FutureOr<void> _eventHandler(AlgsetListEvent event, Emitter<AlgsetListState> emit) async {
    switch (event) {
      case AlgsetListEventLoad():
        return _onLoad(emit);
      case AlgsetListEventAdd():
        return _onAdd(event.algset, emit);

      case AlgsetListEventUpdate():
        return _onUpdate(event.algset, emit);
    }
  }

  FutureOr<void> _onLoad(Emitter<AlgsetListState> emit) async {
    try {
      emit(const AlgsetListStateLoading());
      final algsets = await FirebaseStorageService.instance.getUserAlgsets();
      emit(AlgsetListStateLoaded(algsetList: algsets));
    } catch (e) {
      emit(const AlgsetListStateError());
    }
  }

  FutureOr<void> _onUpdate(Algset algset, Emitter<AlgsetListState> emit) async {
    try {
      emit(const AlgsetListStateLoading());
      await FirebaseStorageService.instance.updateAlgset(algset);
      final algsets = await FirebaseStorageService.instance.getUserAlgsets();
      emit(AlgsetListStateLoaded(algsetList: algsets));
    } catch (e) {
      print(e);
      emit(const AlgsetListStateError());
    }
  }

  FutureOr<void> _onAdd(Algset algset, Emitter<AlgsetListState> emit) async {
    try {
      emit(const AlgsetListStateLoading());
      await FirebaseStorageService.instance.addAlgset(algset);
      final algsets = await FirebaseStorageService.instance.getUserAlgsets();
      emit(AlgsetListStateLoaded(algsetList: algsets));
    } catch (e) {
      print(e);
      emit(const AlgsetListStateError());
    }
  }
}
