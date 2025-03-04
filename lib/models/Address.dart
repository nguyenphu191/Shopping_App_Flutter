class Address {
  late String street;
  late String district;
  late String city;
  late String country;
  Address(
      {required this.street,
      required this.district,
      required this.city,
      required this.country});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    district = json['district'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> address = new Map<String, dynamic>();
    address['street'] = this.street;
    address['district'] = this.district;
    address['city'] = this.city;
    address['country'] = this.country;
    return address;
  }

  @override
  String toString() {
    return '$street, $district, $city, $country';
  }
}
