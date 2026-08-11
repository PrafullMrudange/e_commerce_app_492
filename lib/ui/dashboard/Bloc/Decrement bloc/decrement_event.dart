abstract class DecrementCartEvent {}

class DecrementCartProductEvent extends DecrementCartEvent {
  int userId;
  int productId;
  int quantity;

  DecrementCartProductEvent({
    required this.userId,
    required this.productId,
    required this.quantity,
  });
}
