import 'package:permission_handler/permission_handler.dart';

/// This is used to extend the functionality of the [Permission] package object
///
/// This is to make it easily mocked while testing
class PermissionHandler {
  Future<PermissionStatus> requestStoragePermission() =>
      Permission.storage.request();

  Future<PermissionStatus> status() async => Permission.storage.status;
}
