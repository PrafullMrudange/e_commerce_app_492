abstract class UserEvent {}

class LoginUserEvent extends UserEvent {
  String email, password;

  LoginUserEvent({
    required this.email,
    required this.password
  });
}

class RegisterUserEvent extends UserEvent {
  String name, email, mobilNo, password;

  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.mobilNo,
    required this.password,
  });
}

class CheckLogin extends UserEvent{
  String token;
  CheckLogin({required this.token});
}
