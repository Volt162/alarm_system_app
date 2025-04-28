part of 'alarm_button_cubit.dart';

class AlarmButtonState extends Equatable {
  final AlarmButtonStatus status;
  final bool? isSosDisable;

  @override
  List<Object?> get props => [
        status,
        isSosDisable,
      ];
  const AlarmButtonState({
    this.status = AlarmButtonStatus.inactive,
    this.isSosDisable = false,
  });

  AlarmButtonState copyWith({
    AlarmButtonStatus? status,
    bool? isSosDisable,
  }) {
    return AlarmButtonState(
      status: status ?? this.status,
      isSosDisable: isSosDisable ?? this.isSosDisable,
    );
  }
}

enum AlarmButtonStatus {
  inactive,
  locationStateCheck,
  active,
  press,
  cancelAlarmMessage,
  disconnect,
  error
}

extension AlarmButtonStatusX on AlarmButtonStatus {
  bool get isInactive => this == AlarmButtonStatus.inactive;
  bool get isLocationStateCheck => this == AlarmButtonStatus.locationStateCheck;
  bool get isCancelAlarmMessage => this == AlarmButtonStatus.cancelAlarmMessage;
  bool get isDisconnect => this == AlarmButtonStatus.disconnect;
  bool get isActive => this == AlarmButtonStatus.active;
  bool get isPress => this == AlarmButtonStatus.press;
  bool get isError => this == AlarmButtonStatus.error;
}
