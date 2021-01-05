class UserData {
  static UserData _instance;
  factory UserData() {
    _instance ??= UserData._internalConstructor();
    return _instance;
  }
  UserData._internalConstructor();

  String id;
  String name;
  String email;
}