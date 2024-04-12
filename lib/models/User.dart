class User {
  String? username;
  String? email;
  String? phone;
  String? password;
  String? city;
  String? id;

  User(
      {this.username,
      this.email,
      this.phone,
      this.password,
      this.city,
      this.id});

  // User.fromJson(Map<String, dynamic> json) {
  //   username = json['username'];
  //   email = json['email'];
  //   phone = json['phone'];
  //   password = json['password'];
  //   city = json['city'];
  //   id = json['id'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['username'] = this.username;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['password'] = this.password;
  //   data['city'] = this.city;
  //   data['id'] = this.id;
  //   return data;
  // }
}
