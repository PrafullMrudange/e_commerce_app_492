abstract class DecrementCartState {}

class DecrementCartInitialState extends DecrementCartState {}

class DecrementCartLoadingState extends DecrementCartState {}

class DecrementCartSuccessState extends DecrementCartState {
  String message;
  DecrementCartSuccessState({
    required this.message,
  });
}

class DecrementCartErrorState extends DecrementCartState {
  String error;

  DecrementCartErrorState({
    required this.error,
  });
}