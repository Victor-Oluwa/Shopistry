import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const CheckoutState()) {
    on<UpdateAddress>((event, emit) {
      emit(state.copyWith(
        address: event.address,
        status: CheckoutStatus.initial,
        errorMessage: null,
      ));
    });
    
    on<UpdatePaymentMethod>((event, emit) {
      emit(state.copyWith(
        paymentMethod: event.paymentMethod,
        status: CheckoutStatus.initial,
        errorMessage: null,
      ));
    });

    on<PlaceOrder>((event, emit) async {
      emit(state.copyWith(status: CheckoutStatus.loading));
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (event.order.address.isEmpty) {
        emit(state.copyWith(
          status: CheckoutStatus.failure,
          errorMessage: 'Please provide a delivery address',
        ));
      } else {
        emit(state.copyWith(status: CheckoutStatus.success));
      }
    });
  }
}
