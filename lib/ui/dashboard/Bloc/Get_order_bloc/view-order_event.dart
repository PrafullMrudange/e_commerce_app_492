abstract class ViewOrderEvent {}

class GetOrdersEvent extends ViewOrderEvent {
  int userId;

  GetOrdersEvent({
    required this.userId,
  });
}