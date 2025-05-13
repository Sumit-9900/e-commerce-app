import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

enum PaymentMethod { card, upi, cod }

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentSuccess(PaymentMethod.card));

  void changePaymentTile(PaymentMethod method) {
    emit(PaymentSuccess(method));
  }
}
