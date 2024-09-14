import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseAnalyticsService extends BlocObserver {
  FirebaseAnalyticsService.internal();
  static final FirebaseAnalyticsService _instance = FirebaseAnalyticsService.internal();

  static FirebaseAnalyticsService get instance => _instance;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void onEvent(Bloc bloc, Object? event) {
    Map<String, Object>? getParameters(dynamic event) {
      try {
        return event.toMap() as Map<String, Object>?;
      } catch (e) {
        return null;
      }
    }

    log(
      'Logging event: ${event.runtimeType.toString()}',
      name: 'FirebaseAnalyticsService',
    );

    _analytics.logEvent(
      name: event.runtimeType.toString(),
      parameters: getParameters(event),
    );

    super.onEvent(bloc, event);
  }
}
