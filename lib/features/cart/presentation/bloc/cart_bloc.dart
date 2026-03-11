import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartLoaded(Cart())) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentCart = (state as CartLoaded).cart;
      final existingItemIndex = currentCart.items.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      List<CartItem> updatedItems = List.from(currentCart.items);

      if (existingItemIndex >= 0) {
        final existingItem = updatedItems[existingItemIndex];
        updatedItems[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + event.quantity,
        );
      } else {
        updatedItems.add(CartItem(product: event.product, quantity: event.quantity));
      }

      emit(CartLoaded(Cart(items: updatedItems)));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentCart = (state as CartLoaded).cart;
      final updatedItems = currentCart.items.where(
        (item) => item.product.id != event.productId,
      ).toList();
      emit(CartLoaded(Cart(items: updatedItems)));
    }
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentCart = (state as CartLoaded).cart;
      final updatedItems = currentCart.items.map((item) {
        if (item.product.id == event.productId) {
          return item.copyWith(quantity: event.quantity);
        }
        return item;
      }).toList();
      emit(CartLoaded(Cart(items: updatedItems)));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartLoaded(Cart()));
  }
}
