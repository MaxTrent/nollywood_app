class CreateUserProfileModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  CreateUserProfileModel(
      {required this.error,
      required this.success,
      required this.data,
      required this.code,
      required this.message});

  factory CreateUserProfileModel.fromJson(Map<String, dynamic> json) {
    return CreateUserProfileModel(
      error: json['error'],
      success: json['success'],
      data: Data.fromJson(json['data']),
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'success': success,
      'data': data.toJson(),
      'code': code,
      'message': message,
    };
  }
}

class Data {
  String userId;
  String profession;
  String firstName;
  String lastName;
  String actualAge;
  String gender;
  String skinType;
  List<String> preferredRoles;
  List<String> actorLookalike;
  String backgroundActor;
  List<String> additionalSkills;
  String city;
  String state;
  String country;
  String address;
  String height;
  String primaryLanguage;
  List<String> otherLanguages;
  List<String> linkToReels;
  List<String> awards;
  String education;
  List<String> headshots;
  String filmmakerProfile;
  String companyName;
  String companyEmail;
  String companyPhoneNumber;
  String profilePicture;
  String id;
  List<String> recentProjects;
  String createdAt;
  String updatedAt;
  int v;

  Data(
      {required this.userId,
      required this.profession,
      required this.firstName,
      required this.lastName,
      required this.actualAge,
      required this.gender,
      required this.skinType,
      required this.preferredRoles,
      required this.actorLookalike,
      required this.backgroundActor,
      required this.additionalSkills,
      required this.city,
      required this.state,
      required this.country,
      required this.address,
      required this.height,
      required this.primaryLanguage,
      required this.otherLanguages,
      required this.linkToReels,
      required this.awards,
      required this.education,
      required this.headshots,
      required this.filmmakerProfile,
      required this.companyName,
      required this.companyEmail,
      required this.companyPhoneNumber,
      required this.profilePicture,
      required this.id,
      required this.recentProjects,
      required this.createdAt,
      required this.updatedAt,
      required this.v});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['user_id'],
      profession: json['profession'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      actualAge: json['actual_age'],
      gender: json['gender'],
      skinType: json['skin_type'],
      preferredRoles: List<String>.from(json['preferred_roles']),
      actorLookalike: List<String>.from(json['actor_lookalike']),
      backgroundActor: json['background_actor'],
      additionalSkills: List<String>.from(json['additional_skills']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      address: json['address'],
      height: json['height'],
      primaryLanguage: json['primary_language'],
      otherLanguages: List<String>.from(json['other_languages']),
      linkToReels: List<String>.from(json['link_to_reels']),
      awards: List<String>.from(json['awards']),
      education: json['education'],
      headshots: List<String>.from(json['headshots']),
      filmmakerProfile: json['film_maker_profile'],
      companyName: json['company_name'],
      companyEmail: json['company_email'],
      companyPhoneNumber: json['company_phone_number'],
      profilePicture: json['profile_picture'],
      id: json['_id'],
      recentProjects: List<String>.from(json['recent_projects']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'profession': profession,
      'first_name': firstName,
      'last_name': lastName,
      'actual_age': actualAge,
      'gender': gender,
      'skin_type': skinType,
      'preferred_roles': preferredRoles,
      'actor_lookalike': actorLookalike,
      'background_actor': backgroundActor,
      'additional_skills': additionalSkills,
      'city': city,
      'state': state,
      'country': country,
      'address': address,
      'height': height,
      'primary_language': primaryLanguage,
      'other_languages': otherLanguages,
      'link_to_reels': linkToReels,
      'awards': awards,
      'education': education,
      'headshots': headshots,
      'film_maker_profile': filmmakerProfile,
      'company_name': companyName,
      'company_email': companyEmail,
      'company_phone_number': companyPhoneNumber,
      'profile_picture': profilePicture,
      '_id': id,
      'recent_projects': recentProjects,
      'created_at': createdAt,
      'updated_at': updatedAt,
      '__v': v,
    };
  }
}
