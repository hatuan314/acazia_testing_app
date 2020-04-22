import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {

  var json = {
    "uuid": "0d3b6192-78f8-4b18-90df-4be8bf394556",
    "username": "ticklishzebra345",
    "password": "2222",
    "salt": "EF7HSfIM",
    "md5": "a684d827f3e9d50eaedf481fd7420fa6",
    "sha1": "8d2161df60e29141053c27b8128f87f1418e88dd",
    "sha256": "2f43e6de5314da2f9fc395bc53de1df76f2400db397f834f064d56543e8e5d5e"
  };

  group('Login', () {
    test('fromJson returns is correct Login', () {
      Login loginTest = Login.fromJson(json);
      expect(loginTest.uuid, "0d3b6192-78f8-4b18-90df-4be8bf394556");
      expect(loginTest.username, "ticklishzebra345");
      expect(loginTest.password, "2222");
      expect(loginTest.salt, "EF7HSfIM");
      expect(loginTest.md5, "a684d827f3e9d50eaedf481fd7420fa6");
      expect(loginTest.sha1, "8d2161df60e29141053c27b8128f87f1418e88dd");
      expect(loginTest.sha256, "2f43e6de5314da2f9fc395bc53de1df76f2400db397f834f064d56543e8e5d5e");
    });
  });
}