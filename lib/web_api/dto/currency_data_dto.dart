class CurrencyDataDto {
  String effectiveData;
  double mid;

  CurrencyDataDto({
    required this.effectiveData,
    required this.mid,
  });

  factory CurrencyDataDto.fromJson(Map<String, dynamic> json) {
    return CurrencyDataDto(
      effectiveData: json['effectiveDate'],
      mid: json['mid'],
    );
  }
}
