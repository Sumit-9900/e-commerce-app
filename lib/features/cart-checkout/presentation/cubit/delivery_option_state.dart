part of 'delivery_option_cubit.dart';

sealed class DeliveryOptionState extends Equatable {
  const DeliveryOptionState();

  @override
  List<Object> get props => [];
}

final class DeliveryOptionInitial extends DeliveryOptionState {}

final class DeliveryOptionSuccess extends DeliveryOptionState {
  final DeliveryOption option;
  const DeliveryOptionSuccess(this.option);

  @override
  List<Object> get props => [option];
}
