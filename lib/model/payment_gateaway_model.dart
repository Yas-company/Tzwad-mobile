import 'dart:convert';

PaymentGateAwayModel paymentGateAwayModelFromJson(String str) =>
    PaymentGateAwayModel.fromJson(json.decode(str));

String paymentGateAwayModelToJson(PaymentGateAwayModel data) =>
    json.encode(data.toJson());

class PaymentGateAwayModel {
  PaymentGateAwayModel({
    required this.gatewayList,
  });

  List<Gateway> gatewayList;

  factory PaymentGateAwayModel.fromJson(Map<String, dynamic> json) =>
      PaymentGateAwayModel(
        gatewayList: List<Gateway>.from(
            json["gateway_list"].map((x) => Gateway.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gateway_list": List<dynamic>.from(gatewayList.map((x) => x.toJson())),
      };
}

class Gateway {
  Gateway({
    required this.name,
    required this.testMode,
    required this.logoLink,
    this.appId,
    this.clientId,
    this.secretId,
    this.publicKey,
    this.merchantKey,
    this.merchantMid,
    this.merchantWebsite,
    this.channel,
    this.industryType,
    this.secretKey,
    this.apiKey,
    this.apiSecret,
    this.secretHash,
    this.merchantEmail,
    this.clientSecret,
    this.username,
    this.password,
    this.merchantId,
    this.passphrase,
    this.serverKey,
    this.clientKey,
  });

  String name;
  bool testMode;
  String logoLink;
  String? appId;
  String? clientId;
  String? secretId;
  String? publicKey;
  String? merchantKey;
  String? merchantMid;
  String? merchantWebsite;
  dynamic channel;
  dynamic industryType;
  String? secretKey;
  dynamic apiKey;
  dynamic apiSecret;
  dynamic secretHash;
  String? merchantEmail;
  dynamic clientSecret;
  dynamic username;
  dynamic password;
  dynamic merchantId;
  dynamic passphrase;
  dynamic serverKey;
  dynamic clientKey;

  factory Gateway.fromJson(Map<String, dynamic> json) => Gateway(
        name: json["name"],
        testMode: json["test_mode"],
        logoLink: json["logo_link"],
        appId: json["app_id"],
        clientId: json["client_id"],
        secretId: json["secret_id"],
        publicKey: json["public_key"],
        merchantKey: json["merchant_key"],
        merchantMid: json["merchant_mid"],
        merchantWebsite: json["merchant_website"],
        channel: json["channel"],
        industryType: json["industry_type"],
        secretKey: json["secret_key"],
        apiKey: json["api_key"],
        apiSecret: json["api_secret"],
        secretHash: json["secret_hash"],
        merchantEmail: json["merchant_email"],
        clientSecret: json["client_secret"],
        username: json["username"],
        password: json["password"],
        merchantId: json["merchant_id"],
        passphrase: json["passphrase"],
        serverKey: json["server_key"],
        clientKey: json["client_key"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "test_mode": testMode,
        "logo_link": logoLink,
        "app_id": appId,
        "client_id": clientId,
        "secret_id": secretId,
        "public_key": publicKey,
        "merchant_key": merchantKey,
        "merchant_mid": merchantMid,
        "merchant_website": merchantWebsite,
        "channel": channel,
        "industry_type": industryType,
        "secret_key": secretKey,
        "api_key": apiKey,
        "api_secret": apiSecret,
        "secret_hash": secretHash,
        "merchant_email": merchantEmail,
        "client_secret": clientSecret,
        "username": username,
        "password": password,
        "merchant_id": merchantId,
        "passphrase": passphrase,
        "server_key": serverKey,
        "client_key": clientKey,
      };
}
