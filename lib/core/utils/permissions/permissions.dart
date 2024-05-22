import 'package:permission_handler/permission_handler.dart';
import '../../enums/location_permission.dart';

class PermissionService {
  // Private constructor
  PermissionService._privateConstructor();

  // Singleton instance variable
  static PermissionService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to PermissionService.instance will return the same instance that was created before.

  // Getter to access the singleton instance
  static PermissionService get instance {
    _instance ??= PermissionService._privateConstructor();
    return _instance!;
  }

  //method to get permissions
  Future<LocationPermissionStatus> getLocationPermissionStatus() async {
    await Permission.location.request();

    var status = await Permission.location.status;
    if (status.isGranted) {
      return LocationPermissionStatus.granted;
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before, but not permanently.
      return LocationPermissionStatus.denied;
    } else if (status.isPermanentlyDenied) {
      // We didn't ask for permission yet or the permission has been denied before, but not permanently.
      return LocationPermissionStatus.permanentlyDenied;
    }

    return LocationPermissionStatus.unknown;
  }
}
