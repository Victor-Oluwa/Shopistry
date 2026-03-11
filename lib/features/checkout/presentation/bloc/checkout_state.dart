import 'package:equatable/equatable.dart';

enum CheckoutStatus { initial, loading, success, failure }

class CheckoutState extends Equatable {
  final String address;
  final String paymentMethod;
  final CheckoutStatus status;
  final String? errorMessage;

  const CheckoutState({
    this.address = '',
    this.paymentMethod = 'Credit Card',
    this.status = CheckoutStatus.initial,
    this.errorMessage,
  });

  CheckoutState copyWith({
    String? address,
    String? paymentMethod,
    CheckoutStatus? status,
    String? errorMessage,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [address, paymentMethod, status, errorMessage];
}
