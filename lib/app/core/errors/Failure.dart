import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  final String message;
  final String? error;
  final int statusCode;

  const Failure({
    required this.message,
    this.error,
    required this.statusCode,
  });

  @override
  String toString() =>
      'Failure(message: $message, error: $error, statusCode: $statusCode)';

  @override
  List<Object?> get props => throw UnimplementedError();
}
