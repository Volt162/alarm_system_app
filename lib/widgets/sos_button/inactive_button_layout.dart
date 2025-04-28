import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poruch/config/app_resources/strings.dart';
import 'package:poruch/config/styles.dart';
import 'package:poruch/screens/screens.dart';

class InactiveButtonLayout extends StatelessWidget {
  final double bottomCircleWidth;
  final double buttonWidth;
  final VoidCallback onSetActiveState;
  final VoidCallback onSetPressState;
  final VoidCallback onSetInactiveState;
  final Color bgColor;
  final Color textColor;
  final Color splashColor;

  const InactiveButtonLayout({
    Key? key,
    required this.bottomCircleWidth,
    required this.buttonWidth,
    required this.onSetActiveState,
    required this.onSetPressState,
    required this.onSetInactiveState,
    required this.bgColor,
    required this.textColor,
    required this.splashColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActive = false;
    Timer? _timer;
    Timer? _timerPress;
    final texColor = ValueNotifier(textColor);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: bottomCircleWidth,
          height: bottomCircleWidth,
          decoration: BoxDecoration(
            color: Styles.poruchBlue.withAlpha(130),
            shape: BoxShape.circle,
          ),
        ),
        ClipOval(
          child: Material(
            color: bgColor,
            child: IgnorePointer(
              ignoring: false,
              child: InkWell(
                enableFeedback: true,
                onTapCancel: () {
                  if (bottomBarKey.currentState != null) {
                    bottomBarKey.currentState!.updateBottomBarBlockTouchTabsState(false);
                  }
                  texColor.value = textColor;
                  _timer?.cancel();
                  _timerPress?.cancel();
                  if (!isActive) {
                    onSetInactiveState.call();
                  }
                },
                onTapUp: (details) {
                  if (bottomBarKey.currentState != null) {
                    bottomBarKey.currentState!.updateBottomBarBlockTouchTabsState(false);
                  }
                  _timer?.cancel();
                  _timerPress?.cancel();
                  onSetInactiveState.call();
                  texColor.value = textColor;
                },
                onTapDown: (details) {
                  if (bottomBarKey.currentState != null) {
                    bottomBarKey.currentState!.updateBottomBarBlockTouchTabsState(true);
                  }
                  _timerPress = Timer(const Duration(milliseconds: 500), () {
                    onSetPressState.call();
                    texColor.value = Styles.poruchBlack;
                  });
                  _timer = Timer(const Duration(seconds: 3), () {
                    HapticFeedback.heavyImpact();
                    isActive = true;
                    onSetActiveState.call();
                  });
                },
                onTap: () {
                  onSetInactiveState.call();
                },
                highlightColor: Colors.transparent,
                splashColor: splashColor,
                child: Container(
                  width: buttonWidth,
                  height: buttonWidth,
                  alignment: Alignment.center,
                  child: ValueListenableBuilder<Color>(
                    valueListenable: texColor,
                    builder: (context, value, child) {
                      return Text(
                        Strings.sos,
                        style: Styles.poruchHeader0
                            .copyWith(color: texColor.value),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
