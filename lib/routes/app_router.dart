import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poruch/screens/screens.dart';

class AppRouter {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('This is route: ${settings.name}');
    }

    switch (settings.name) {
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case RegistrationScreen.routeName:
        return RegistrationScreen.route();
      case VereficationCodeScreen.routeName:
        return VereficationCodeScreen.route(
            isNeedToUpdatePhone: settings.arguments == null
                ? false
                : settings.arguments as bool);
      case AuthorizationScreen.routeName:
        return AuthorizationScreen.route();
      case AuthErrorScreen.routeName:
        return AuthErrorScreen.route(isDeviceError: settings.arguments as bool);
      case UpdatePhoneScreen.routeName:
        return UpdatePhoneScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case PaymentScreen.routeName:
        return PaymentScreen.route();
      case TariffChangedScreen.routeName:
        return TariffChangedScreen.route();
      case LocationDescriptionScreen.routeName:
        return LocationDescriptionScreen.route();
      case UnpaidSubscriptionScreen.routeName:
        return UnpaidSubscriptionScreen.route();
      case PublicContractScreen.routeName:
        return PublicContractScreen.route();
      case TermsOfUseScreen.routeName:
        return TermsOfUseScreen.route();
      case GbrDateScreen.routeName:
        return GbrDateScreen.route();
      case EditProfileInfoScreen.routeName:
        return EditProfileInfoScreen.route(
            type: settings.arguments as EditProfileForm);
      case BrowserScreen.routeName:
        return BrowserScreen.route(url: settings.arguments as String);
      case IndividualPaymentBrowserScreen.routeName:
        return IndividualPaymentBrowserScreen.route(
            url: settings.arguments as String);

      default:
        return throw Exception("Unknown page route: ${settings.name}");
    }
  }
}
