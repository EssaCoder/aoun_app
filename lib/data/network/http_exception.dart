class HttpException implements Exception {
  final String? message;
  final String? prefix;

  HttpException({required this.message, required this.prefix});

  @override
  String toString() {
    return "$message$prefix";
  }
}

class FetchDataException extends HttpException {
  FetchDataException([String? message])
      : super(message: message??"", prefix: "Error During Communication: ");
}

class BadRequestException extends HttpException {
  BadRequestException([message])
      : super(message: message, prefix: "Invalid Request: ");
}

class UnauthorisedException extends HttpException {
  UnauthorisedException([message])
      : super(message: message, prefix: "Unauthorised: ");
}

class DataRequiredException extends HttpException {
  DataRequiredException([message])
      : super(message: message, prefix: "DataRequiredException: ");
}

class InvalidInputException extends HttpException {
  InvalidInputException([String? message])
      : super(message: message??"", prefix: "Invalid Input: ");
}

class TimeOutException extends HttpException {
  TimeOutException([message])
      : super(message: message, prefix: "kTimeOutException");
}
class ConnectionException extends HttpException {
  ConnectionException([message])
      : super(message: message, prefix: "kTimeOutException");
}
class ExistUserException extends HttpException {
  ExistUserException([message])
      : super(message: message, prefix: "existUserException");
}