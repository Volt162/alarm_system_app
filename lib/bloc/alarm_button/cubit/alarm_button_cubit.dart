import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:location/location.dart';
import 'package:poruch/config/app_resources/constants.dart';
import 'package:poruch/models/models.dart';
import 'package:poruch/services/protocol/pult_service.dart';
import 'package:poruch/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'alarm_button_state.dart';

class AlarmButtonCubit extends Cubit<AlarmButtonState> {
  final IPultService _pultService;
  final IlocationService _locationService;
  late SharedPreferences pref;
  int? _tabIndex;

  AlarmButtonCubit(this._pultService, this._locationService)
      : super(const AlarmButtonState());

  Future<void> setInitState() async {
    pref = await SharedPreferences.getInstance();
    StreamSubscription subscription = _pultService.alarmStateUpdates.listen(
      (state) async {
        print("new AlarmState: $state");
        switch (state) {
          case 0:
            setDisconnectState();
            break;
          case 2:
            setCamcelAlarmMessageState();
            break;
          case 3:
            await Future.delayed(const Duration(milliseconds: 500));
            setInactiveState();
            onTabClicked();
            break;
          default:
        }
      },
    );
    _pultService.streamSubscriptions["AlarmButtonCubit"] = subscription;
  }

  Future<void> setDisconnectState() async {
    setInactiveState();
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: AlarmButtonStatus.disconnect, isSosDisable: true));
  }

  Future<void> setActiveState() async {
    emit(state.copyWith(status: AlarmButtonStatus.active));
    bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) {
      final pref = await SharedPreferences.getInstance();
      if (pref.getBool(Constants.isVibrateOn) ?? false) {
        Vibrate.vibrate();
      }
    }

    await _pultService.sendAlarmMessage();
    final AlarmButtonActivatedDto dto = AlarmButtonActivatedDto(
      login: pref.getString(Constants.login),
      imei: pref.getString(Constants.imei),
      create: DateTime.now(),
      date: DateTime.now(),
    );
    await _pultService.alarmButtonActivated(dto);
  }

  Future<void> setInactiveState() async {
    emit(state.copyWith(status: AlarmButtonStatus.inactive, isSosDisable: false));
  }

  Future<void> setCamcelAlarmMessageState() async {
    emit(state.copyWith(status: AlarmButtonStatus.inactive));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: AlarmButtonStatus.cancelAlarmMessage));
    await Future.delayed(const Duration(milliseconds: 3000));
    emit(state.copyWith(status: AlarmButtonStatus.inactive));
  }

  Future<void> setPressState() async {
    emit(state.copyWith(status: AlarmButtonStatus.press));
  }

  Future<void> onResumed() async {
    await onTabClicked();
  }

  Future<void> onTabClicked({int? tabIndex}) async {
    _tabIndex = tabIndex ?? _tabIndex;
    if ((_tabIndex == 0 || (_tabIndex == null && tabIndex == null)) && !_pultService.isDisconnectAllertShown) {
      emit(state.copyWith(status: AlarmButtonStatus.locationStateCheck));
      bool isLocationEnable =
          await _locationService.serviceEnbledOnlyCheck(location: Location());
      if (isLocationEnable && state.isSosDisable!) {
        emit(
          state.copyWith(status: AlarmButtonStatus.inactive, isSosDisable: false),
        );
        try {
          AlertController.hide();
        } catch (e) {
          //
        }
      } else if (!isLocationEnable) {
        emit(state.copyWith(
            status: AlarmButtonStatus.disconnect, isSosDisable: true));
        _pultService.showLocationAlert();
      }
    }
    else if (_pultService.isDisconnectAllertShown && !state.isSosDisable!) {
      emit(state.copyWith(
          status: AlarmButtonStatus.disconnect, isSosDisable: true));
    }
  }
}
