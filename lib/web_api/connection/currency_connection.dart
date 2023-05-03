import 'package:currency_exchange/web_api/exceptions/cant_fetch_data.dart';
import 'package:currency_exchange/web_api/service/api_service.dart';
import 'package:http/http.dart';

class CurrencyConnection {
  final apiService = ApiService();

  Future<String> getMidCurrency(String currencyCode) async {
    final Response response = await apiService.makeApiGetRequest(
        'http://api.nbp.pl/api/exchangerates/rates/A/$currencyCode/?format=json');

    if (response.statusCode == 404) {
      throw CantFetchDataException();
    } else {
      return response.body;
    }
  }

  Future<String> getLastMonthCurrency(String currencyCode) async {
    final Response response = await apiService.makeApiGetRequest(
        'http://api.nbp.pl/api/exchangerates/rates/A/$currencyCode/last/30/?format=json');

    if (response.statusCode == 404) {
      throw CantFetchDataException();
    } else {
      return response.body;
    }
  }
}
