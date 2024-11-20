class UserModel {
  String? fullName;
  String? id;
  String? phone;
  String? gender;
  String? age;
  String? password;
  String? confirmPassword;
  UserModel({
    this.fullName,
    this.id,
    this.phone,
    this.gender,
    this.age,
    this.password
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    fullName = json?['fullName'];
    id = json?['id'];
    phone = json?['phone'];
    gender = json?['gender'];
    age = json?['age'];
    password = json?['password'];
  }
  // to json

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['id'] = id;
    data['phone'] = phone;
    data['gender'] = gender;
    data['age'] = age;
    data['password'] = password;

    return data;
  }
}
