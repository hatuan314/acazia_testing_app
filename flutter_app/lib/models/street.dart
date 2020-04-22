class Street {
  String number;
  String name;

  Street({this.number, this.name});

  Street.fromJson(Map<String, dynamic> json) {
    number = json['number'].toString();
    name = json['name'];
  }

  String getAddress() {
    return '$number $name';
  }
}
