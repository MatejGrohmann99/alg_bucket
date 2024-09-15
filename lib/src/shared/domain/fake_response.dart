import 'package:dartz/dartz.dart';

import 'error_response.dart';

abstract class FakeResponse {
  static Future<Right<ErrorResponse, T>> success<T>(T data) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(data);
  }

  static Future<Left<ErrorResponse, T>> error<T>() async {
    await Future.delayed(const Duration(seconds: 1));
    return Left(
      ErrorResponse(
        message: 'Developer was to lazy to implement this feature.',
        error: 'Error',
        stackTrace: StackTrace.current,
      ),
    );
  }
}
