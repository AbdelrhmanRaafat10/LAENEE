class UserModel {
  late String? userName;
  late String? email;
  // ignore: non_constant_identifier_names
  late String? DateofBirth;
  late String? address;
  late String? uid;
  late String? bio;
  late String? gender;
  late bool? isEmailVerified;
  late String? profileImage;
  late String? coverImage;
  late String? token;

  UserModel(
      {this.profileImage,
        this.coverImage,
        this.bio,
        this.userName,
        this.email,
        // ignore: non_constant_identifier_names
        this.DateofBirth,
        this.address,
        this.uid,
        this.gender,
        this.isEmailVerified,
        this.token});

  UserModel.fromJson(Map<String, dynamic>? json) {
    uid = json?['uid'];
    userName = json?["Username"];

    email = json?["Email"];

    DateofBirth = json?[" DateofBirth"];
    address = json?["address"];

    gender = json?["gender"];
    profileImage = json?["profileImage"];
    coverImage = json?["coverImage"];
    bio = json?["bio"];
    isEmailVerified = json?["isEmailVerified"];
    token = json?["token"];
  }

  Map<String, dynamic>? toMap() {
    return {
      "Username": userName,
      "Email": email,
      " DateofBirth": DateofBirth,
      "address": address,
      "uid": uid,
      "bio": bio,
      "profileImage": profileImage,
      "coverImage": coverImage,
      "gender": gender,
      "isEmailVerified ": isEmailVerified,
      "token": token,
    };
  }
}