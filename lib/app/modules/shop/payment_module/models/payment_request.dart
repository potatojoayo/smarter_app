import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentRequest {
  final String method;
  int? amount;
  int? couponId;
  String? orderId;
  String? orderName;
  String? customerName;
  String? smarterMoney;

  // billing auth
  String? customerKey;

  // card direct
  String? flowMode;
  String? cardCompany;

  // virtual account
  int? validHours;
  Map<String, String>? cashReceipt;

  // account transfer
  String? bank;

  PaymentRequest({
    required this.method,
    this.amount,
    this.orderId,
    this.orderName,
    this.customerName,
    this.smarterMoney,
    this.couponId,

    // billing auth
    this.customerKey,

    // card direct
    this.flowMode,
    this.cardCompany,

    // account transfer
    this.bank,
  });

  Map<String, dynamic> get toJson {
    Map<String, dynamic> paymentRequest = {};

    paymentRequest.addAll({"method": method});

    if (amount != null) {
      paymentRequest.addAll({"amount": "$amount"});
    }

    if (orderId != null) {
      paymentRequest.addAll({"orderId": orderId});
    }
    if (orderName != null) {
      paymentRequest.addAll({"orderName": orderName});
    }
    if (customerName != null) {
      paymentRequest.addAll({"customerName": customerName});
    }
    if (customerKey != null) {
      paymentRequest.addAll({"customerKey": customerKey});
    }
    if (flowMode != null) {
      paymentRequest.addAll({"flowMode": flowMode});
    }
    if (cardCompany != null) {
      paymentRequest.addAll({"card_company": cardCompany});
    }
    if (bank != null) {
      paymentRequest.addAll({"bank": bank});
    }
    if (smarterMoney != null) {
      paymentRequest.addAll({"smarterMoney": smarterMoney});
    }
    if (couponId != null) {
      paymentRequest.addAll({"couponId": couponId});
    }

    return paymentRequest;
  }

  Uri get url {
    String path = '';
    switch (method) {
      case '카드':
        path = 'card';
        break;
      case '계좌이체':
      default:
        path = 'transfer';
    }
    final result = Uri.http(
        dotenv.env['BASE_URL']!
            .replaceAll('https://', '')
            .replaceAll('http://', ''),
        "payment/$path/",
        toJson);
    return result;
  }

  factory PaymentRequest.depositWithoutAccount(
      {required int amount,
      required String orderId,
      required String orderName,
      required String customerName}) {
    return PaymentRequest(
      method: '무통장입금',
      amount: amount,
      orderId: orderId,
      orderName: orderName,
      customerName: customerName,
    );
  }

  factory PaymentRequest.card(
      {required int amount,
      required String orderId,
      required String orderName,
      required String customerName,
      required String smarterMoney,
      int? couponId}) {
    return PaymentRequest(
        method: "카드",
        amount: amount,
        orderId: orderId,
        orderName: orderName,
        customerName: customerName,
        smarterMoney: smarterMoney);
  }

  factory PaymentRequest.cardDirect({
    required int amount,
    required String orderId,
    required String orderName,
    required String customerName,
    required String cardCompany,
  }) {
    return PaymentRequest(
      method: "카드앱바로열기",
      amount: amount,
      orderId: orderId,
      orderName: orderName,
      customerName: customerName,
      flowMode: "DIRECT",
      cardCompany: cardCompany,
    );
  }

  factory PaymentRequest.billingAuth({
    required String customerKey,
  }) {
    return PaymentRequest(
      method: "카드자동결제",
      customerKey: customerKey,
    );
  }

  factory PaymentRequest.virtualAccount({
    required int amount,
    required String orderId,
    required String orderName,
    required String customerName,
    // int? validHours,
    // Map<String, String>? cashReceipt,
  }) {
    return PaymentRequest(
      method: "가상계좌",
      amount: amount,
      orderId: orderId,
      orderName: orderName,
      customerName: customerName,
    );
  }

  factory PaymentRequest.transfer({
    required int amount,
    required String orderId,
    required String orderName,
    required String customerName,
    required String bank,
    required String smarterMoney,
    int? couponId,
  }) {
    return PaymentRequest(
      method: "계좌이체",
      amount: amount,
      orderId: orderId,
      orderName: orderName,
      smarterMoney: smarterMoney,
      customerName: customerName,
      couponId: couponId,
      bank: bank,
    );
  }
}
