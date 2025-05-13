import 'package:ecommerce_app/features/cart-checkout/presentation/enums/payment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentSuccess(PaymentMethod.card));

  void changePaymentTile(PaymentMethod method) {
    emit(PaymentSuccess(method));
  }
}
