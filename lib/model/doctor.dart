import 'package:hive/hive.dart';
part 'doctor.g.dart';

@HiveType(typeId: 1)
class Doctor {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? profilePic;
  @HiveField(4)
  bool? favorite;
  @HiveField(5)
  String? primaryContactNo;
  @HiveField(6)
  String? rating;
  @HiveField(7)
  String? emailAddress;
  @HiveField(8)
  String? qualification;
  @HiveField(9)
  String? description;
  @HiveField(10)
  String? specialization;
  @HiveField(11)
  String? languagesKnown;
  @HiveField(12)
  DateTime? dateOfBirth;
  @HiveField(13)
  String? bloodGroup;
  @HiveField(14)
  int? height;
  @HiveField(15)
  int? weight;
  @HiveField(16)
  int? phoneNumber;
  @HiveField(17)
  String? gender;

  Doctor({
    this.id,
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
    this.languagesKnown,
    this.dateOfBirth,
    this.bloodGroup,
    this.height,
    this.weight,
    this.phoneNumber,
    this.gender,
  });

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
    dateOfBirth = DateTime.parse(json["dateOfBirth"] ?? "0000-00-00");
    bloodGroup = json["bloodGroup"] ?? "A+";
    height = json["height"] ?? 0;
    weight = json["weight"] ?? 0;
    gender = json["gender"] ?? "Gender";
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
    data["dateOfBirth"] = dateOfBirth.toString();
    data["bloodGroup"] = bloodGroup;
    data["height"] = height;
    data["weight"] = weight;
    data["gender"] = gender;
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
    DateTime? dateOfBirth,
    String? bloodGroup,
    int? height,
    int? weight,
    String? gender,
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
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
          bloodGroup: bloodGroup ?? this.bloodGroup,
          height: height ?? this.height,
          weight: weight ?? this.weight,
          gender: gender ?? this.gender);
}
