class UserEntity {
  String id = '-1';
  String firstName = '';
  String lastName = '';
  String avatar = '';
  String email = '';
  String phone = '';
  String birthday = '';
  String password = '';
  String genre = '';

  UserEntity.origin();

  UserEntity(this.id, this.firstName, this.lastName, this.avatar, this.birthday,
      this.email, this.phone, this.password, this.genre);

  Map userToMap() => new Map<String, dynamic>.from({
        "id": this.id,
        "first_name": this.firstName,
        "last_name": this.lastName,
        "avatar": this.avatar,
        "email": this.email,
        "phone": this.phone,
        "password": this.password,
        "birthday": this.birthday,
        "genre": this.genre
      });

  static List<Map> userToListMap(List<UserEntity> users) {
    List<Map> usersMap = [];
    users.forEach((UserEntity user) {
      Map step = user.userToMap();
      usersMap.add(step);
    });
    return usersMap;
  }
}
