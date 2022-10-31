class Bill {
  String billCode;
  String billName;
  int billPrice;
  DateTime expired;

  Bill(
      {required this.billCode,
      required this.billName,
      required this.billPrice,
      required this.expired});
}