import 'package:currency_exchange/bloc/currency_bloc/currency_bloc.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_event/currency_chart_event.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_event/currency_get_mid_event.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_chart.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_initial.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_loading.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_mid.dart';
import 'package:currency_exchange/bloc/currency_bloc/currency_state/currency_state.dart';
import 'package:currency_exchange/pages/currency_page/currency_widgets/dropdown_button.dart';
import 'package:currency_exchange/web_api/dto/currency_data_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CurrencyPage extends StatelessWidget {
  CurrencyPage({super.key});
  late double w;
  late double h;
  bool isChartPage = false;
  late String actualCurrency;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: w * .04),
            child: CurrencyDropDownButton(
              onChanged: (currency) {
                actualCurrency = currency;
                if (!isChartPage) {
                  context
                      .read<CurrencyBloc>()
                      .add(CurrencyGetMidEvent(currency));
                } else {
                  context
                      .read<CurrencyBloc>()
                      .add(CurrencychartEvent(currency));
                }
              },
            ),
          ),
          BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              if (state is CurrencyInitial) {
                return Column(
                  children: [
                    SizedBox(
                      height: w * .3,
                    ),
                    Center(child: Image.asset('assets/currencylogo.png')),
                  ],
                );
              } else if (state is CurrencyMid) {
                isChartPage = false;
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: h * .03),
                      height: w * .3,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Ostatni średni odczyt waluty: "),
                          ),
                          Text(
                              '${context.read<CurrencyBloc>().currencyDataDto.code} ${context.read<CurrencyBloc>().currencyDataDto.mid} do PLN, data ${context.read<CurrencyBloc>().currencyDataDto.effectiveData} '),
                          Container(
                            padding: EdgeInsets.only(top: h * .01),
                            width: w * .7,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<CurrencyBloc>().add(
                                    CurrencychartEvent(context
                                        .read<CurrencyBloc>()
                                        .currencyDataDto
                                        .code));
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blueGrey[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                "Wyświetl zestawienie dla najbliższych 30 dni",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(child: Image.asset('assets/currencylogo.png')),
                  ],
                );
              } else if (state is CurrencyChart) {
                isChartPage = true;
                List<CurrencyDataDto> currencyList =
                    context.read<CurrencyBloc>().currencyList;
                return Column(
                  children: [
                    SizedBox(
                      height: h * .05,
                    ),
                    Center(
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(
                                text:
                                    'Miesięczny wykres kursu waluty ${context.read<CurrencyBloc>().currencyDataDto.code}'),
                            series: <LineSeries<CurrencyDataDto, String>>[
                          LineSeries<CurrencyDataDto, String>(
                              dataSource: currencyList,
                              xValueMapper: (CurrencyDataDto currency, _) =>
                                  currency.effectiveData,
                              yValueMapper: (CurrencyDataDto currency, _) =>
                                  currency.mid)
                        ])),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<CurrencyBloc>()
                              .add(CurrencyGetMidEvent(actualCurrency));
                        },
                        child: const Text(
                          "Powrót do strony głównej",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                );
              } else if (state is CurrencyLoading) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: h * .1),
                  child: const CircularProgressIndicator(),
                ));
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
