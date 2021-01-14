import 'package:ext_storage/ext_storage.dart';

/// This is used to extend the functionality of the [ExtStorage] package object
///
/// This is to make it easily mocked while testing
class ExternalStorage {
  Future<String> getExternalStorageDirectory() =>
      ExtStorage.getExternalStorageDirectory();
}
