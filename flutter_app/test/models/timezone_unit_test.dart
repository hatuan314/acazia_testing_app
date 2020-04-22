import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  var json = {
    "offset": "-7:00",
    "description": "Mountain Time (US & Canada)"
  };

  group('Timezone', () {
    test('fromJson returns correct Timezone', () {
      var timezoneTest = Timezone.fromJson(json);

      expect(timezoneTest.offset, "-7:00");
      expect(timezoneTest.description, "Mountain Time (US & Canada)");
    });
  });
}
