import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poruch/bloc/cubits.dart';
import 'package:poruch/bloc/test_mode/cubit/test_mode_cubit.dart';
import 'package:poruch/widgets/sos_button/active_button_layout.dart';
import 'package:poruch/widgets/sos_button/inactive_button_layout.dart';

// ignore: must_be_immutable
class SosButton extends StatefulWidget {
  final VoidCallback onSetActiveState;
  final VoidCallback onSetPressState;
  final VoidCallback onSetInactiveState;
  final Color activeBgColor;
  final Color activeTextColor;
  final Color inactiveBgColor;
  final Color inactiveTextColor;
  final Color splashColor;
  bool isActiveState;
  bool isAlarmConfirmedState;
  bool isTestButton;

  SosButton({
    super.key,
    required this.onSetActiveState,
    required this.onSetPressState,
    required this.onSetInactiveState,
    this.isActiveState = false,
    this.isAlarmConfirmedState = false,
    this.isTestButton = false,
    required this.activeBgColor,
    required this.activeTextColor,
    required this.inactiveBgColor,
    required this.inactiveTextColor,
    required this.splashColor,
  });

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> with WidgetsBindingObserver {
  bool isActiveState = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!widget.isTestButton && state == AppLifecycleState.resumed) {
      context.read<TestModeCubit>().onResumed(state, !widget.isTestButton && isActiveState);
      context.read<AlarmButtonCubit>().onResumed();
    }
  }

  void setActiveState() {
    setState(() {
      isActiveState = true;
      widget.isActiveState = true;
      widget.onSetActiveState.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width * 0.95;
    final _bottomCircleWidth = _screenWidth * 0.65;
    final _buttonWidth = _bottomCircleWidth - 40;

    return SizedBox(
      width: _screenWidth,
      height: _screenWidth,
      child: widget.isActiveState
          ? ActiveButtonLayout(
              bgColor: widget.activeBgColor,
              textColor: widget.activeTextColor,
              buttonWidth: _buttonWidth,
              isAlarmConfirmed: widget.isAlarmConfirmedState,
              isTestButton: widget.isTestButton,
            )
          : InactiveButtonLayout(
              bgColor: widget.inactiveBgColor,
              textColor: widget.inactiveTextColor,
              splashColor: widget.splashColor,
              bottomCircleWidth: _bottomCircleWidth,
              buttonWidth: _buttonWidth,
              onSetActiveState: setActiveState,
              onSetPressState: () {
                widget.onSetPressState.call();
              },
              onSetInactiveState: () {
                isActiveState = false;
                widget.onSetInactiveState.call();
              },
            ),
    );
  }

  @override
  void didChangeDependencies() {
    isActiveState = widget.isActiveState;
    super.didChangeDependencies();
  }
}
