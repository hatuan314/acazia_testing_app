import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  var street = Street(
      number: '7315',
      name: "Calle de Arturo Soria"
  );

  var json = {
    "number": 7315,
    "name": "Calle de Arturo Soria"
  };

  group("Street", () {
    test('fromTest returns correct Street', () {
      var streetTest = Street.fromJson(json);

      expect(streetTest.number, '7315');
      expect(streetTest.name, 'Calle de Arturo Soria');
    });
  });
}