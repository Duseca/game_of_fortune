import 'dart:io';

class AdService {
  AdService._privateConstructor();

  // Singleton instance variable
  static AdService? _instance;

  // Getter to access the singleton instance
  static AdService get instance {
    _instance ??= AdService._privateConstructor();
    return _instance!;
  }

  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5103565823373972/6194131078";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9071761241773942/4687169441";
    }
    return null;
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9071761241773942/3445852924';
    } else if (Platform.isIOS) {
      return "ca-app-pub-9071761241773942~6612219463";
    }
    return null;
  }
}
