import 'package:flutterapp/models/model.dart';
import 'package:flutterapp/service/service.dart';

class Repository {
  Provider _provider = Provider();

  Future<List<Person>> fetchAllPersonsRepository() => _provider.fetchAllPersonsProvider();
}