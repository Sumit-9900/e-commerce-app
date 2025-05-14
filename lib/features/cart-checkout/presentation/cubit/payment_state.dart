part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentSuccess extends PaymentState {
  final PaymentMethod method;
  const PaymentSuccess(this.method);

  @override
  List<Object> get props => [method];
}
