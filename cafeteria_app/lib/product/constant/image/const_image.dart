class AppConstantImage {
  static AppConstantImage? _instance;
  static AppConstantImage get instance {
    _instance ??= AppConstantImage._init();
    return _instance!;
  }

  String get constImagePath => "assets/error/error.png";
  AppConstantImage._init();
}
