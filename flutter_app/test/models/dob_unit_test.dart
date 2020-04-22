import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/dob.dart';

void main() {
  var json = {"date": "1985-03-14T09:40:08.186Z", "age": 35};

  group('Dob', () {
    test('fromJson returns correct Dob', () {
      var dobTest = Dob.fromJson(json);

      expect(dobTest.date, "1985-03-14T09:40:08.186Z");
      expect(dobTest.age, '35');
    });
  });
}
