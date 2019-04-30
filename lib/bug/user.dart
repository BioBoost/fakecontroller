class User {
  String _id = "";
  String _name = "";

  User(String id, String name) {
    _id = id;
    _name = name;
  }

  String getId() {
    return _id;
  }

  String getName() {
    return _name;
  }
}