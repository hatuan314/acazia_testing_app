import 'dart:convert';

import 'package:flutterapp/models/model.dart';
import 'package:flutterapp/service/web_service.dart';

class Provider {
  final _service = WebService();

  Future<List<Person>> fetchAllPersonsProvider() async {
    final dio = _service.setupDio();
    final List<Person> allPerson = List<Person>();
    final response = await dio.get('?results=10');
    if (response.data['error'] != null) {
      return null;
    } else {
      if (response.data['results'] != null) {
        response.data['results'].forEach((v) {
          allPerson.add(new Person.fromJson(v));
        });
      }
      dio.close();
      return allPerson;
    }
  }
}