import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
    print("Notification permission granted.");
  } else if (status.isDenied) {
    print("Notification permission denied.");
  } else if (status.isPermanentlyDenied) {
    print("Notification permission permanently denied. Please enable it in the settings.");
    openAppSettings(); // Open app settings to manually enable the permission.
  }
}
