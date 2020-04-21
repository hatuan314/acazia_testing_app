import 'package:intl/intl.dart';

class Dob {
  String date;
  String age;

  Dob({this.date, this.age});

  Dob.fromJson(Map<String, dynamic> json) {
    date = DateFormat('dd/MM/yyyy').format(DateTime.parse(json['date']));
    age = json['age'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['age'] = this.age;
    return data;
  }
}