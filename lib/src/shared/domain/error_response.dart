import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  final String message;

  final dynamic error;

  final StackTrace stackTrace;

  const ErrorResponse({
    required this.message,
    required this.error,
    required this.stackTrace,
  });

  static Left<ErrorResponse, T> from<T>({
    required String message,
    required dynamic error,
    required StackTrace stackTrace,
  }) {
    return Left(ErrorResponse(
      message: message,
      error: error,
      stackTrace: stackTrace,
    ));
  }

  @override
  List<Object?> get props => [message, error, stackTrace];
}
