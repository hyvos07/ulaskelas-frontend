part of '_error.dart';

abstract class Failure implements Exception {
  Failure({
    this.title,
    this.code,
    this.message,
  });

  String? title;

  /// In case server provider error codes.
  String? code;

  /// Hold Error Message.
  String? message;
}

class DioFailure implements Exception {
  DioFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
      case DioExceptionType.connectionError:
        message = 'Connection to API server failed due to internet connection';
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
      case DioExceptionType.badCertificate:
        message = 'Invalid certificate from client';
      case DioExceptionType.badResponse:
        message = 'Bad response output from API server';
      case DioExceptionType.unknown:
        message = _handleResponseError(dioException.response);
    }
  }

  String message = 'Permintaan gagal, silahkan coba lagi atau hubungi admin';

  String _handleResponseError(Response? res) {
    var errorMessage = message;

    // ignore:
    if (res?.data['message'] != null) {
      errorMessage = res!.data['message'].toString();
    }

    if (res?.data['errors'] != null) {
      errorMessage = res!.data['errors'].toString();
    }

    if (res?.data['error'] != null) {
      errorMessage = res!.data['error'].toString();
    }

    return errorMessage;
  }

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  NetworkFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Network Failure',
        );
}

class NotFoundFailure extends Failure {
  NotFoundFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Not Found Failure',
        );
}

class BadRequestFailure extends Failure {
  BadRequestFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Bad Request Failure',
        );
}

class GeneralFailure extends Failure {
  GeneralFailure({
    super.message,
  }) : super(
          title: 'General Failure',
        );
}

class TimeoutFailure extends Failure {
  TimeoutFailure({
    super.message,
  }) : super(
          title: 'Timeout Failure',
        );
}

class ArgumentFailure extends Failure {
  ArgumentFailure({
    super.message,
  }) : super(
          title: 'Argument Failure',
        );
}

class UnAuthorizeFailure extends Failure {
  UnAuthorizeFailure({
    super.message,
  }) : super(
          title: 'UnAuthorize Failure',
        );
}

class ParseFailure extends Failure {}

class EmptyFailure extends Failure {}
