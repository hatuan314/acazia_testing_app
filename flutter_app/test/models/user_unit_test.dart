import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  group('Person', () {
    var jsonData = {
      "results": [
        {
          "gender": "male",
          "name": {
            "title": "Mr",
            "first": "Aitor",
            "last": "Saez"
          },
          "location": {
            "street": {
              "number": 7315,
              "name": "Calle de Arturo Soria"
            },
            "city": "Alicante",
            "state": "Extremadura",
            "country": "Spain",
            "postcode": 22802,
            "coordinates": {
              "latitude": "-20.7487",
              "longitude": "-23.2116"
            },
            "timezone": {
              "offset": "-7:00",
              "description": "Mountain Time (US & Canada)"
            }
          },
          "email": "aitor.saez@example.com",
          "login": {
            "uuid": "0d3b6192-78f8-4b18-90df-4be8bf394556",
            "username": "ticklishzebra345",
            "password": "2222",
            "salt": "EF7HSfIM",
            "md5": "a684d827f3e9d50eaedf481fd7420fa6",
            "sha1": "8d2161df60e29141053c27b8128f87f1418e88dd",
            "sha256": "2f43e6de5314da2f9fc395bc53de1df76f2400db397f834f064d56543e8e5d5e"
          },
          "dob": {
            "date": "1985-03-14T09:40:08.186Z",
            "age": 35
          },
          "registered": {
            "date": "2018-05-16T11:55:00.516Z",
            "age": 2
          },
          "phone": "979-152-333",
          "cell": "665-755-967",
          "id": {
            "name": "DNI",
            "value": "00319784-K"
          },
          "picture": {
            "large": "https://randomuser.me/api/portraits/men/50.jpg",
            "medium": "https://randomuser.me/api/portraits/med/men/50.jpg",
            "thumbnail": "https://randomuser.me/api/portraits/thumb/men/50.jpg"
          },
          "nat": "ES"
        }
      ],
      "info": {
        "seed": "a689a72b3a5e6a0c",
        "results": 1,
        "page": 1,
        "version": "1.3"
      }
    };

    test('formJson return correct Person', () {


      List obj = jsonData['results'];
      final personTest = Person.fromJson(obj[0]);
      expect(personTest.gender, "male");
      expect(personTest.email,  "aitor.saez@example.com");
      expect(personTest.location.street.number,  '7315');
      expect(personTest.dob.age, '35');
    });

    test('toJson return correct Map', () {

    });
  });
}
