import 'package:app/models/providers/API_provider.dart';
import 'package:app/models/providers/storage_provider.dart';

abstract class AbstractService {
  final StorageProvider storageProvider;
  final ApiProvider apiProvider;

  AbstractService({required this.storageProvider, required this.apiProvider});
}