enum CacheKeys {
  LOCALE("LOCALE");

  final String value;
  const CacheKeys(this.value);

  String get rawValue => name;
}
