class Passenger {
  String firstName;
  String middleName;
  String lastName;
  String dob;
  String gender;
  String email;
  String phone;
  int id;

  Passenger();

  Passenger._(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.dob,
      this.email,
      this.phone});

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return new Passenger._(
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        dob: json['dob'],
        gender: json['gender'],
        email: json['email'],
        phone: json['phone']);
  }

  Map asMap() {
    Map map = Map();
    map['firstName'] = firstName;
    map['middleName'] = middleName;
    map['lastName'] = lastName;
    map['dob'] = dob;
    map['gender'] = gender;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }
}
