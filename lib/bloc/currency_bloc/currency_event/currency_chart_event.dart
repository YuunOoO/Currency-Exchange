import 'package:currency_exchange/bloc/currency_bloc/currency_event/currency_event.dart';

class CurrencychartEvent extends CurrencyEvent {
  final String currencyCode;

  const CurrencychartEvent(this.currencyCode);

  @override
  List<Object> get props => [currencyCode];
}
