import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<bool> checkPermissionLocation();
}

class PermissionServiceImpl with PermissionMixin implements PermissionService {
  const PermissionServiceImpl();

  @override
  Future<bool> checkPermissionLocation() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
    // return _checkPermission(permission: Permission.location);
  }
}

mixin PermissionMixin {
  // Future<bool> _checkPermission({
  //   required Permission permission,
  // }) async {
  //   final status = await permission.status;
  //   if (status == PermissionStatus.granted || status == PermissionStatus.limited) {
  //     return true;
  //   }
  //   final result = await permission.request();
  //   return result == PermissionStatus.granted || result == PermissionStatus.limited;
  // }
}
