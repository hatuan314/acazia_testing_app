import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  var json =  {
    "name": "DNI",
    "value": "00319784-K"
  };

  group('Id', () {
    test('fromJson returns correct Id', () {
      var idTest = Id.fromJson(json);

      expect(idTest.name, "DNI");
      expect(idTest.value, "00319784-K");
    });
  });
}