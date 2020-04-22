import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  group('Location', () {

    test('fromJson returns correct Location', () {
      final jsonTest = {
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
      };


      Location locationTest = Location.fromJson(jsonTest);

      expect(locationTest.street.number, '7315');
      expect(locationTest.state, 'Extremadura');
      expect(locationTest.coordinates.latitude, '-20.7487');
      expect(locationTest.timezone.description, 'Mountain Time (US & Canada)');
    });
  });
}