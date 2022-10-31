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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billName'] = this.billName;
    data['billDescription'] = this.billDescription;
    data['billTo'] = this.billTo;
    data['billEmail'] = this.billEmail;
    data['billPhone'] = this.billPhone;
    data['billStatus'] = this.billStatus;
    data['billpaymentStatus'] = this.billpaymentStatus;
    data['billpaymentChannel'] = this.billpaymentChannel;
    data['billpaymentAmount'] = this.billpaymentAmount;
    data['billpaymentInvoiceNo'] = this.billpaymentInvoiceNo;
    data['billSplitPayment'] = this.billSplitPayment;
    data['billSplitPaymentArgs'] = this.billSplitPaymentArgs;
    data['billpaymentSettlement'] = this.billpaymentSettlement;
    data['billpaymentSettlementDate'] = this.billpaymentSettlementDate;
    data['billPaymentDate'] = this.billPaymentDate;
    data['billExternalReferenceNo'] = this.billExternalReferenceNo;
    return data;
  }
}