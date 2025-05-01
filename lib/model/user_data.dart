class UsersData {
  String userName;
  String password;
  String name;
  String email;
  String city;
  List? addresses = [];
  UsersData(this.userName, this.password, this.name, this.email, this.city,
      {this.addresses});
}
