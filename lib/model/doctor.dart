class Doctor {
  int? id;
  String? firstName;
  String? lastName;
  String? profilePic;
  bool? favorite;
  String? primaryContactNo;
  String? rating;
  String? emailAddress;
  String? qualification;
  String? description;
  String? specialization;
  String? languagesKnown;

  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.favorite,
      this.primaryContactNo,
      this.rating,
      this.emailAddress,
      this.qualification,
      this.description,
      this.specialization,
      this.languagesKnown});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    profilePic = json["profile_pic"];
    favorite = json["favorite"];
    primaryContactNo = json["primary_contact_no"];
    rating = json["rating"];
    emailAddress = json["email_address"];
    qualification = json["qualification"];
    description = json["description"];
    specialization = json["specialization"];
    languagesKnown = json["languagesKnown"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["profile_pic"] = profilePic;
    data["favorite"] = favorite;
    data["primary_contact_no"] = primaryContactNo;
    data["rating"] = rating;
    data["email_address"] = emailAddress;
    data["qualification"] = qualification;
    data["description"] = description;
    data["specialization"] = specialization;
    data["languagesKnown"] = languagesKnown;
    return data;
  }

  Doctor copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? profilePic,
    bool? favorite,
    String? primaryContactNo,
    String? rating,
    String? emailAddress,
    String? qualification,
    String? description,
    String? specialization,
    String? languagesKnown,
  }) =>
      Doctor(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profilePic: profilePic ?? this.profilePic,
        favorite: favorite ?? this.favorite,
        primaryContactNo: primaryContactNo ?? this.primaryContactNo,
        rating: rating ?? this.rating,
        emailAddress: emailAddress ?? this.emailAddress,
        qualification: qualification ?? this.qualification,
        description: description ?? this.description,
        specialization: specialization ?? this.specialization,
        languagesKnown: languagesKnown ?? this.languagesKnown,
      );
}
