import 'package:liqpay/src/models/liqpay_action.dart';
import 'package:liqpay/src/models/liqpay_card.dart';
import 'package:liqpay/src/models/liqpay_currency.dart';
import 'package:liqpay/src/models/liqpay_language.dart';

class LiqPayOrder {
  final String id;
  final double amount;

  /// Payment description.
  final String description;

  /// Payment action
  final LiqPayAction action;

  /// Payment currency
  final LiqPayCurrency currency;

  /// Card details (number, cvv etc.)
  final LiqPayCard? card;

  /// Customer's language.
  final LiqPayLanguage? language;

  /// Subscribe type.
  final String? subscribe;
  final String? subscribeDateStart;
  final String? subscribePeriodicity;

  /// Pay type.
  final String? paytypes;

  ///Token
  final String? recurringbytoken;
  final String? info;

  /// More details here: https://www.liqpay.ua/en/documentation/api/callback
  final String? serverUrl;

  const LiqPayOrder(this.id, this.amount, this.description, this.subscribeDateStart,
      {this.card,
      this.info,
      this.serverUrl,
      this.subscribe,
      this.subscribePeriodicity,
      this.paytypes,
      this.recurringbytoken,
      this.action = LiqPayAction.pay,
      this.currency = LiqPayCurrency.uah,
      this.language = LiqPayLanguage.uk});

  factory LiqPayOrder.fromJson(Map<String, dynamic> json) => LiqPayOrder(
        json['order_id'] as String,
        json['amount'] as double,
        json['description'] as String,
        json['subscribe_date_start'] as String,
        subscribe: json['subscribe'] as String,
        subscribePeriodicity: json['subscribe_periodicity'] as String,
        paytypes: json['paytypes'] as String,
        recurringbytoken: json['recurringbytoken'] as String,
        info: json['info'] as String,
        serverUrl: json['server_url'],
        card: LiqPayCard(
            json['card'] as String,
            json['card_exp_month'] as String,
            json['card_exp_year'] as String,
            json['card_cvv'] as String),
        action: LiqPayAction.fromValue(json['action']),
        currency: LiqPayCurrency.fromValue(json['currency']),
      );

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'order_id': id,
      'amount': amount,
      'description': description,
      'action': action.value,
      'currency': currency.value,
    };

    if (card != null) {
      json['card'] = card?.number;
      json['card_exp_month'] = card?.expirationMonth;
      json['card_exp_year'] = card?.expirationYear;
      json['card_cvv'] = card?.cvv;
    }

    if (serverUrl != null) {
      json['server_url'] = serverUrl;
    }

    if (subscribeDateStart != null) {
      json['subscribe_date_start'] = subscribeDateStart;
    }

    if (subscribe != null) {
      json['subscribe'] = subscribe;
    }

    if (subscribePeriodicity != null) {
      json['subscribe_periodicity'] = subscribePeriodicity;
    }

    if (paytypes != null) {
      json['paytypes'] = paytypes;
    }

    if (recurringbytoken != null) {
      json['recurringbytoken'] = recurringbytoken;
    }

    if (info != null) {
      json['info'] = info;
    }

    return json;
  }
}
