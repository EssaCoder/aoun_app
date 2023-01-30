class SharedValues {
  SharedValues._privateConstructor();
  static final SharedValues _instance = SharedValues._privateConstructor();
  static SharedValues get instance => _instance;
  static String loginRoute = "/login";

  static const double padding = 10;
  static const double borderRadius = 10;
}
