import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  var json = {"latitude": "-20.7487", "longitude": "-23.2116"};

  group('Coordinates', () {
    test('fromJson returns correct Coordinates', () {
      var coordinatesTest = Coordinates.fromJson(json);

      expect(coordinatesTest.latitude, "-20.7487");
      expect(coordinatesTest.longitude, "-23.2116");
    });
  });
}
