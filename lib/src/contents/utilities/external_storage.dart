import 'package:ext_storage/ext_storage.dart';

class ExternalStorage {
  Future<String> getExternalStorageDirectory() =>
      ExtStorage.getExternalStorageDirectory();
}
