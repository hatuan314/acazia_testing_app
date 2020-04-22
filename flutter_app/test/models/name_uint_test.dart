import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  group('Name', () {
    Name name = Name(title: "Mr", first: "Aitor", last: "Saez");

    test('fromJson returns correct Name', () {
      final json = {"title": "Mr", "first": "Aitor", "last": "Saez"};
      final nameTest = Name.fromJson(json);

      expect(nameTest.title, 'Mr');
      expect(nameTest.first, 'Aitor');
      expect(nameTest.last, 'Saez');
    });

    test('getFullName returns correct', () {
      final fullName = name.getFullName();

      expect(fullName, 'Aitor Saez');
    });
  });
}
