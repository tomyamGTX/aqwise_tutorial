class BillTransaction {
  String? billName;
  String? billDescription;
  String? billTo;
  String? billEmail;
  String? billPhone;
  String? billStatus;
  String? billpaymentStatus;
  String? billpaymentChannel;
  String? billpaymentAmount;
  String? billpaymentInvoiceNo;
  String? billSplitPayment;
  String? billSplitPaymentArgs;
  String? billpaymentSettlement;
  String? billpaymentSettlementDate;
  String? billPaymentDate;
  String? billExternalReferenceNo;

  BillTransaction(
      {this.billName,
      this.billDescription,
      this.billTo,
      this.billEmail,
      this.billPhone,
      this.billStatus,
      this.billpaymentStatus,
      this.billpaymentChannel,
      this.billpaymentAmount,
      this.billpaymentInvoiceNo,
      this.billSplitPayment,
      this.billSplitPaymentArgs,
      this.billpaymentSettlement,
      this.billpaymentSettlementDate,
      this.billPaymentDate,
      this.billExternalReferenceNo});

  BillTransaction.fromJson(Map<String, dynamic> json) {
    billName = json['billName'];
    billDescription = json['billDescription'];
    billTo = json['billTo'];
    billEmail = json['billEmail'];
    billPhone = json['billPhone'];
    billStatus = json['billStatus'];
    billpaymentStatus = json['billpaymentStatus'];
    billpaymentChannel = json['billpaymentChannel'];
    billpaymentAmount = json['billpaymentAmount'];
    billpaymentInvoiceNo = json['billpaymentInvoiceNo'];
    billSplitPayment = json['billSplitPayment'];
    billSplitPaymentArgs = json['billSplitPaymentArgs'];
    billpaymentSettlement = json['billpaymentSettlement'];
    billpaymentSettlementDate = json['billpaymentSettlementDate'];
    billPaymentDate = json['billPaymentDate'];
    billExternalReferenceNo = json['billExternalReferenceNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billName'] = billName;
    data['billDescription'] = billDescription;
    data['billTo'] = billTo;
    data['billEmail'] = billEmail;
    data['billPhone'] = billPhone;
    data['billStatus'] = billStatus;
    data['billpaymentStatus'] = billpaymentStatus;
    data['billpaymentChannel'] = billpaymentChannel;
    data['billpaymentAmount'] = billpaymentAmount;
    data['billpaymentInvoiceNo'] = billpaymentInvoiceNo;
    data['billSplitPayment'] = billSplitPayment;
    data['billSplitPaymentArgs'] = billSplitPaymentArgs;
    data['billpaymentSettlement'] = billpaymentSettlement;
    data['billpaymentSettlementDate'] = billpaymentSettlementDate;
    data['billPaymentDate'] = billPaymentDate;
    data['billExternalReferenceNo'] = billExternalReferenceNo;
    return data;
  }
}
