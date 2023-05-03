class CurrencyMidDataDto {
  String effectiveData;
  double mid;
  String code;

  CurrencyMidDataDto({
    required this.effectiveData,
    required this.mid,
    required this.code,
  });

  factory CurrencyMidDataDto.fromJson(Map<String, dynamic> json) {
    return CurrencyMidDataDto(
      effectiveData: json['rates'][0]['effectiveDate'],
      mid: json['rates'][0]['mid'],
      code: json['code'],
    );
  }
}
