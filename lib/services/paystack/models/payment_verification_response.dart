class PaymentVerificationResponse {
  bool status;
  String message;
  Data data;

  PaymentVerificationResponse({required this.status,required this.message,required this.data});

  PaymentVerificationResponse.fromJson(Map<String, dynamic> json) :
    status = json['status'],
    message = json['message'],
    data = Data.fromJson(json['data']) ;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  int? id;
  String? domain;
  String status;
  String? reference;
  String? receiptNumber;
  int? amount;
  String? message;
  String? gatewayResponse;
  String? paidAt;
  String? createdAt;
  String? channel;
  String? currency;
  String? ipAddress;
  String? metadata;
  Log? log;
  int? fees;
  Authorization? authorization;
  Customer? customer;
  String? transactionDate;

  Data({this.id, this.domain,required this.status, this.reference, this.receiptNumber, this.amount, this.message, this.gatewayResponse, this.paidAt, this.createdAt, this.channel, this.currency, this.ipAddress, this.metadata, this.log, this.fees, this.authorization, this.customer,this.transactionDate});

  Data.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    domain = json['domain'],
    status = json['status'],
    reference = json['reference'],
    receiptNumber = json['receipt_number'],
    amount = json['amount'],
    message = json['message'],
    gatewayResponse = json['gateway_response'],
    paidAt = json['paid_at'],
    createdAt = json['created_at'],
    channel = json['channel'],
    currency = json['currency'],
    ipAddress = json['ip_address'],
    metadata = json['metadata'],
    log = json['log'] != null ? new Log.fromJson(json['log']) : null,
    fees = json['fees'],
    authorization = json['authorization'] != null ? new Authorization.fromJson(json['authorization']) : null,
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null,
    transactionDate = json['transaction_date'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['domain'] = this.domain;
    data['status'] = this.status;
    data['reference'] = this.reference;
    data['receipt_number'] = this.receiptNumber;
    data['amount'] = this.amount;
    data['message'] = this.message;
    data['gateway_response'] = this.gatewayResponse;
    data['paid_at'] = this.paidAt;
    data['created_at'] = this.createdAt;
    data['channel'] = this.channel;
    data['currency'] = this.currency;
    data['ip_address'] = this.ipAddress;
    data['metadata'] = this.metadata;
    if (this.log != null) {
      data['log'] = this.log!.toJson();
    }
    data['fees'] = this.fees;
    if (this.authorization != null) {
      data['authorization'] = this.authorization!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['paidAt'] = this.paidAt;
    data['createdAt'] = this.createdAt;
    data['transaction_date'] = this.transactionDate;
    return data;
  }
}

class Log {
  int? startTime;
  int? timeSpent;
  int? attempts;
  int? errors;
  bool? success;
  bool? mobile;
  List<History>? history;

  Log({this.startTime, this.timeSpent, this.attempts, this.errors, this.success, this.mobile, this.history});

  Log.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    timeSpent = json['time_spent'];
    attempts = json['attempts'];
    errors = json['errors'];
    success = json['success'];
    mobile = json['mobile'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) { history!.add(new History.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['time_spent'] = this.timeSpent;
    data['attempts'] = this.attempts;
    data['errors'] = this.errors;
    data['success'] = this.success;
    data['mobile'] = this.mobile;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? type;
  String? message;
  int? time;

  History({this.type, this.message, this.time});

  History.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}

class Authorization {
  String? authorizationCode;
  String? bin;
  String? last4;
  String? expMonth;
  String? expYear;
  String? channel;
  String? cardType;
  String? bank;
  String? countryCode;
  String? brand;
  bool? reusable;
  String? signature;
  String? accountName;

  Authorization({this.authorizationCode, this.bin, this.last4, this.expMonth, this.expYear, this.channel, this.cardType, this.bank, this.countryCode, this.brand, this.reusable, this.signature, this.accountName});

  Authorization.fromJson(Map<String, dynamic> json) {
    authorizationCode = json['authorization_code'];
    bin = json['bin'];
    last4 = json['last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    channel = json['channel'];
    cardType = json['card_type'];
    bank = json['bank'];
    countryCode = json['country_code'];
    brand = json['brand'];
    reusable = json['reusable'];
    signature = json['signature'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorization_code'] = this.authorizationCode;
    data['bin'] = this.bin;
    data['last4'] = this.last4;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['channel'] = this.channel;
    data['card_type'] = this.cardType;
    data['bank'] = this.bank;
    data['country_code'] = this.countryCode;
    data['brand'] = this.brand;
    data['reusable'] = this.reusable;
    data['signature'] = this.signature;
    data['account_name'] = this.accountName;
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? customerCode;
  String? phone;
  String? metadata;
  String? riskAction;
  String? internationalFormatPhone;

  Customer({this.id, this.firstName, this.lastName, this.email, this.customerCode, this.phone, this.metadata, this.riskAction, this.internationalFormatPhone});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    customerCode = json['customer_code'];
    phone = json['phone'];
    metadata = json['metadata'];
    riskAction = json['risk_action'];
    internationalFormatPhone = json['international_format_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['customer_code'] = this.customerCode;
    data['phone'] = this.phone;
    data['metadata'] = this.metadata;
    data['risk_action'] = this.riskAction;
    data['international_format_phone'] = this.internationalFormatPhone;
    return data;
  }
}

