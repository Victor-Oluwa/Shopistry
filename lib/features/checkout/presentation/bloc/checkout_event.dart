import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAddress extends CheckoutEvent {
  final String address;
  const UpdateAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class UpdatePaymentMethod extends CheckoutEvent {
  final String paymentMethod;
  const UpdatePaymentMethod(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class PlaceOrder extends CheckoutEvent {
  final Order order;
  const PlaceOrder(this.order);

  @override
  List<Object?> get props => [order];
}
