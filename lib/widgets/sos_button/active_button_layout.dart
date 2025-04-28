import 'package:flutter/material.dart';
import 'package:poruch/config/app_resources/images.dart';
import 'package:poruch/config/app_resources/strings.dart';
import 'package:poruch/config/styles.dart';
import 'package:ripple_wave/ripple_wave.dart';

class ActiveButtonLayout extends StatelessWidget {
  final double buttonWidth;
  final Color bgColor;
  final Color textColor;
  final bool isAlarmConfirmed;
  final bool isTestButton;

  const ActiveButtonLayout({
    Key? key,
    required this.buttonWidth,
    required this.bgColor,
    required this.textColor,
    required this.isAlarmConfirmed,
    required this.isTestButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleWave(
      childTween: Tween(begin: 1.0, end: 1.0),
      color: bgColor,
      duration: const Duration(milliseconds: 1000),
      repeat: true,
      child: ClipOval(
        child: Material(
          color: bgColor,
          child: SizedBox(
            width: buttonWidth,
            height: buttonWidth,
            child: !isAlarmConfirmed
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.sos,
                        style: Styles.poruchHeader0.copyWith(color: textColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        Strings.alarmActivated,
                        style: Styles.poruchBody2.copyWith(color: textColor),
                      ),
                    ],
                  )
                : !isTestButton ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.sos,
                        style: Styles.poruchHeader0.copyWith(color: textColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        Strings.alarmActivated,
                        style: Styles.poruchBody2.copyWith(color: textColor),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Images.checkBlack),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          textAlign: TextAlign.center,
                          Strings.testModeActivated,
                          style: Styles.poruchBody2.copyWith(color: textColor),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
