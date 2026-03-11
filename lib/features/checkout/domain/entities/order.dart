import 'package:equatable/equatable.dart';

import '../../../cart/domain/entities/cart_item.dart';

class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String address;
  final String paymentMethod;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, items, subtotal, deliveryFee, total, address, paymentMethod, createdAt];
}
