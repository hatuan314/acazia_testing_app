import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  var json = {
    "large": "https://randomuser.me/api/portraits/men/50.jpg",
    "medium": "https://randomuser.me/api/portraits/med/men/50.jpg",
    "thumbnail": "https://randomuser.me/api/portraits/thumb/men/50.jpg"
  };
  
  group('Picture', () {
    test('fromJson returns correct Picture', () {
      var pictureTest = Picture.fromJson(json);

      expect(pictureTest.large, "https://randomuser.me/api/portraits/men/50.jpg");
      expect(pictureTest.medium, "https://randomuser.me/api/portraits/med/men/50.jpg");
      expect(pictureTest.thumbnail, "https://randomuser.me/api/portraits/thumb/men/50.jpg");
    });
  });
}