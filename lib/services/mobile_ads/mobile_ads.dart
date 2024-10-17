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
      return "ca-app-pub-9071761241773942/1639034317";
    }
    return null;
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5103565823373972/6393241932';
    } else if (Platform.isIOS) {
      return "ca-app-pub-9071761241773942/1639034317";
    }
  }
}
