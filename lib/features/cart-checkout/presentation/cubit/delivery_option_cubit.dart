import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delivery_option_state.dart';

enum DeliveryOption { standard, express }

class DeliveryOptionCubit extends Cubit<DeliveryOptionState> {
  DeliveryOptionCubit()
    : super(const DeliveryOptionSuccess(DeliveryOption.standard));

  void toggleDeliveryOption(DeliveryOption option) {
    emit(DeliveryOptionSuccess(option));
  }
}
