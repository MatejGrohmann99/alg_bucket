import 'dart:async';

import 'package:alg_bucket/src/algset/domain/algset_api_interface.dart';
import 'package:alg_bucket/src/shared/domain/error_response.dart';
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

  Future<void> _eventHandler(AlgsetListEvent event, Emitter<AlgsetListState> emit) async {
    switch (event) {
      case AlgsetListEventLoad():
        return await _onLoad(emit);
      case AlgsetListEventAdd():
        return await _onAdd(event.algset, emit);

      case AlgsetListEventUpdate():
        return await _onUpdate(event.algset, emit);
    }
  }

  Future<void> _onLoad(Emitter<AlgsetListState> emit) async {
    emit(const AlgsetListStateLoading());

    await AlgsetApiInterface.instance.getUserAlgsets().then(
          (getResponse) async => getResponse.fold(
            (l) => emit(AlgsetListStateError(l)),
            (r) => emit(AlgsetListStateLoaded(algsetList: r)),
          ),
        );
  }

  Future<void> _onUpdate(Algset algset, Emitter<AlgsetListState> emit) async {
    emit(const AlgsetListStateLoading());
    await AlgsetApiInterface.instance.updateAlgset(algset).then(
          (updateResponse) async => await updateResponse.fold(
            (l) async => emit(AlgsetListStateError(l)),
            (r) async => AlgsetApiInterface.instance.getUserAlgsets().then(
                  (getResponse) => getResponse.fold(
                    (l) async => emit(AlgsetListStateError(l)),
                    (r) async => emit(AlgsetListStateLoaded(algsetList: r)),
                  ),
                ),
          ),
        );
  }

  Future<void> _onAdd(Algset algset, Emitter<AlgsetListState> emit) async {
    emit(const AlgsetListStateLoading());

    await AlgsetApiInterface.instance.addAlgset(algset).then(
          (addResponse) async => await addResponse.fold(
            (l) async => emit(AlgsetListStateError(l)),
            (r) async => AlgsetApiInterface.instance.getUserAlgsets().then(
                  (getResponse) => getResponse.fold(
                    (l) async => emit(AlgsetListStateError(l)),
                    (r) async => emit(AlgsetListStateLoaded(algsetList: r)),
                  ),
                ),
          ),
        );
  }
}
