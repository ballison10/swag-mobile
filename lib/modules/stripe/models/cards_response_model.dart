class CardsResponseModel {
  String? object;
  List<Data>? data;
  bool? hasMore;
  String? url;

  CardsResponseModel({this.object, this.data, this.hasMore, this.url});

  CardsResponseModel.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = this.object;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = this.hasMore;
    data['url'] = this.url;
    return data;
  }
}

class Data {
  String? id;
  String? object;
  BillingDetails? billingDetails;
  Card? card;
  int? created;
  String? customer;
  bool? livemode;
  // String? metadata;
  String? type;

  Data(
      {this.id,
      this.object,
      this.billingDetails,
      this.card,
      this.created,
      this.customer,
      this.livemode,
      // this.metadata,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    billingDetails = json['billing_details'] != null
        ? BillingDetails.fromJson(json['billing_details'])
        : null;
    card = json['card'] != null ? Card.fromJson(json['card']) : null;
    created = json['created'];
    customer = json['customer'];
    livemode = json['livemode'];
    // metadata = json['metadata'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['object'] = this.object;
    if (this.billingDetails != null) {
      data['billing_details'] = this.billingDetails!.toJson();
    }
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    data['created'] = this.created;
    data['customer'] = this.customer;
    data['livemode'] = this.livemode;
    // data['metadata'] = this.metadata;
    data['type'] = this.type;
    return data;
  }
}

class BillingDetails {
  Address? address;
  String? email;
  String? name;
  String? phone;

  BillingDetails({this.address, this.email, this.name, this.phone});

  BillingDetails.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Address {
  String? city;
  String? country;
  String? line1;
  String? line2;
  String? postalCode;
  String? state;

  Address(
      {this.city,
      this.country,
      this.line1,
      this.line2,
      this.postalCode,
      this.state});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    line1 = json['line1'];
    line2 = json['line2'];
    postalCode = json['postal_code'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = this.city;
    data['country'] = this.country;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['postal_code'] = this.postalCode;
    data['state'] = this.state;
    return data;
  }
}

class Card {
  String? brand;
  Checks? checks;
  String? country;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? generatedFrom;
  String? last4;
  Networks? networks;
  ThreeDSecureUsage? threeDSecureUsage;
  String? wallet;

  Card(
      {this.brand,
      this.checks,
      this.country,
      this.expMonth,
      this.expYear,
      this.fingerprint,
      this.funding,
      this.generatedFrom,
      this.last4,
      this.networks,
      this.threeDSecureUsage,
      this.wallet});

  Card.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    checks = json['checks'] != null ? Checks.fromJson(json['checks']) : null;
    country = json['country'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    fingerprint = json['fingerprint'];
    funding = json['funding'];
    generatedFrom = json['generated_from'];
    last4 = json['last4'];
    networks =
        json['networks'] != null ? Networks.fromJson(json['networks']) : null;
    threeDSecureUsage = json['three_d_secure_usage'] != null
        ? ThreeDSecureUsage.fromJson(json['three_d_secure_usage'])
        : null;
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = this.brand;
    if (this.checks != null) {
      data['checks'] = this.checks!.toJson();
    }
    data['country'] = this.country;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['fingerprint'] = this.fingerprint;
    data['funding'] = this.funding;
    data['generated_from'] = this.generatedFrom;
    data['last4'] = this.last4;
    if (this.networks != null) {
      data['networks'] = this.networks!.toJson();
    }
    if (this.threeDSecureUsage != null) {
      data['three_d_secure_usage'] = this.threeDSecureUsage!.toJson();
    }
    data['wallet'] = this.wallet;
    return data;
  }
}

class Checks {
  String? addressLine1Check;
  String? addressPostalCodeCheck;
  String? cvcCheck;

  Checks({this.addressLine1Check, this.addressPostalCodeCheck, this.cvcCheck});

  Checks.fromJson(Map<String, dynamic> json) {
    addressLine1Check = json['address_line1_check'];
    addressPostalCodeCheck = json['address_postal_code_check'];
    cvcCheck = json['cvc_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_line1_check'] = this.addressLine1Check;
    data['address_postal_code_check'] = this.addressPostalCodeCheck;
    data['cvc_check'] = this.cvcCheck;
    return data;
  }
}

class Networks {
  List<String>? available;
  String? preferred;

  Networks({this.available, this.preferred});

  Networks.fromJson(Map<String, dynamic> json) {
    available = json['available'].cast<String>();
    preferred = json['preferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available'] = this.available;
    data['preferred'] = this.preferred;
    return data;
  }
}

class ThreeDSecureUsage {
  bool? supported;

  ThreeDSecureUsage({this.supported});

  ThreeDSecureUsage.fromJson(Map<String, dynamic> json) {
    supported = json['supported'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supported'] = this.supported;
    return data;
  }
}