import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/models/model.dart';
import 'package:flutterapp/service/provider.dart';

void main() {
  test('Fetch Random User Data', () async {
    Provider provider = Provider();
    List<Person> people = await provider.fetchAllPersonsProvider();
    bool flag = false;
    if (people != null)
      flag = true;
    expect(flag, true);
  });
}