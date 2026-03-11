import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class Cart extends Equatable {
  final List<CartItem> items;

  const Cart({this.items = const []});

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  
  // Delivery fee is fixed or calculated
  double get deliveryFee => items.isEmpty ? 0 : 5000; 
  
  double get total => subtotal + deliveryFee;

  @override
  List<Object?> get props => [items];
}
