import 'dart:convert';

import 'package:currency_exchange/bloc/currency_bloc/currency_event/currency_chart_event.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_event/currency_event.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_event/currency_get_mid_event.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_chart.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_initial.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_loading.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_mid.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_state.dart';
import 'package:currency_exchange/web_api/connection/currency_connection.dart';
import 'package:currency_exchange/web_api/dto/currency_data_dto.dart';
import 'package:currency_exchange/web_api/dto/currency_mid_data_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyConnection currencyConnection = CurrencyConnection();
  late CurrencyMidDataDto currencyDataDto;
  List<CurrencyDataDto> currencyList = [];

  CurrencyBloc() : super(CurrencyInitial()) {
    on<CurrencyGetMidEvent>((event, emit) async {
      emit(CurrencyInitial());
      currencyDataDto = CurrencyMidDataDto.fromJson(jsonDecode(
          await currencyConnection.getMidCurrency(event.currencyCode)));
      emit(CurrencyMid());
    });

    on<CurrencychartEvent>((event, emit) async {
      emit(CurrencyLoading());
      await Future.delayed(const Duration(seconds: 1));
      var json = jsonDecode(
          await currencyConnection.getLastMonthCurrency(event.currencyCode));
      currencyList = json['rates']
          .map<CurrencyDataDto>(
            (json) => CurrencyDataDto.fromJson(json),
          )
          .toList();
      emit(CurrencyChart());
    });
  }
}
