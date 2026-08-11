class AppException implements Exception {
  String title, msg;

  AppException({required this.title, required this.msg});

  @override
  String toString() {
    return "$title: $msg";
  }
}

class NoInternetException extends AppException {
  String message;
  NoInternetException({required this.message})
      : super(title: "No Internet", msg: message);
}

class BadRequestException extends AppException {
  String message;
  BadRequestException({required this.message})
      : super(title: "Bad Request", msg: message);
}

class UnauthorisedException extends AppException {
  String message;
  UnauthorisedException({required this.message})
      : super(title: "Unauthorised", msg: message);
}

class InvalidInputException extends AppException {
  String message;
  InvalidInputException({required this.message})
      : super(title: "Invalid Input", msg: message);
}

class ServerException extends AppException {
  String message;
  ServerException({required this.message})
      : super(title: "Server Error", msg: message);
}

class NotFoundException extends AppException {
  String message;
  NotFoundException({required this.message})
      : super(title: "Not Found", msg: message);
}

class ConflictException extends AppException {
  String message;
  ConflictException({required this.message})
      : super(title: "Conflict", msg: message);
}

class FetchDataException extends AppException {
  String message;
  FetchDataException({required this.message})
      : super(title: "Error During Communication", msg: message);
}