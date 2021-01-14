import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<PermissionStatus> requestStoragePermission() =>
      Permission.storage.request();

  Future<PermissionStatus> status() async => Permission.storage.status;
}
