import 'package:currency_exchange/bloc/currency_bloc/currency_event/currency_event.dart';

class CurrencyGetMidEvent extends CurrencyEvent {
  final String currencyCode;

  const CurrencyGetMidEvent(this.currencyCode);

  @override
  List<Object> get props => [currencyCode];
}
