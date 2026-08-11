abstract class OrderEvent{}

class CreateOrderEvent extends OrderEvent {
  final int userId;

  CreateOrderEvent({
    required this.userId,
  });
}