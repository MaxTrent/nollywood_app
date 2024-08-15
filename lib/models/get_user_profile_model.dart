class GetUserProfileModel {
    GetUserProfileModel({
        required this.error,
        required this.success,
        required this.data,
        required this.code,
        required this.message,
    });

    final bool? error;
    final bool? success;
    final Data? data;
    final int? code;
    final String? message;

    factory GetUserProfileModel.fromJson(Map<String, dynamic> json){ 
        return GetUserProfileModel(
            error: json["error"],
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            code: json["code"],
            message: json["message"],
        );
    }

}

class Data {
    Data({
        required this.id,
        required this.userId,
        required this.profession,
        required this.firstName,
        required this.lastName,
        required this.actualAge,
        required this.playableAge,
        required this.gender,
        required this.skinType,
        required this.preferredRoles,
        required this.actorLookalike,
        required this.additionalSkills,
        required this.height,
        required this.primaryLanguage,
        required this.otherLanguages,
        required this.city,
        required this.state,
        required this.country,
        required this.address,
        required this.frontHeadshot,
        required this.sideHeadshot,
        required this.linkToReels,
        required this.awards,
        required this.education,
        required this.filmMakerProfile,
        required this.companyName,
        required this.companyEmail,
        required this.companyPhoneNumber,
        required this.profilePicture,
        required this.endorsements,
        required this.totalRatings,
        required this.averageRating,
        required this.followers,
        required this.following,
        required this.recentProjects,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? userId;
    final String? profession;
    final String? firstName;
    final String? lastName;
    final DateTime? actualAge;
    final String? playableAge;
    final String? gender;
    final String? skinType;
    final List<dynamic> preferredRoles;
    final List<dynamic> actorLookalike;
    final List<dynamic> additionalSkills;
    final String? height;
    final String? primaryLanguage;
    final List<dynamic> otherLanguages;
    final String? city;
    final String? state;
    final String? country;
    final String? address;
    final String? frontHeadshot;
    final String? sideHeadshot;
    final List<dynamic> linkToReels;
    final List<dynamic> awards;
    final String? education;
    final String? filmMakerProfile;
    final String? companyName;
    final String? companyEmail;
    final String? companyPhoneNumber;
    final String? profilePicture;
    final int? endorsements;
    final int? totalRatings;
    final int? averageRating;
    final int? followers;
    final int? following;
    final List<dynamic> recentProjects;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["_id"],
            userId: json["user_id"],
            profession: json["profession"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            actualAge: DateTime.tryParse(json["actual_age"] ?? ""),
            playableAge: json["playable_age"],
            gender: json["gender"],
            skinType: json["skin_type"],
            preferredRoles: json["preferred_roles"] == null ? [] : List<dynamic>.from(json["preferred_roles"]!.map((x) => x)),
            actorLookalike: json["actor_lookalike"] == null ? [] : List<dynamic>.from(json["actor_lookalike"]!.map((x) => x)),
            additionalSkills: json["additional_skills"] == null ? [] : List<dynamic>.from(json["additional_skills"]!.map((x) => x)),
            height: json["height"],
            primaryLanguage: json["primary_language"],
            otherLanguages: json["other_languages"] == null ? [] : List<dynamic>.from(json["other_languages"]!.map((x) => x)),
            city: json["city"],
            state: json["state"],
            country: json["country"],
            address: json["address"],
            frontHeadshot: json["front_headshot"],
            sideHeadshot: json["side_headshot"],
            linkToReels: json["link_to_reels"] == null ? [] : List<dynamic>.from(json["link_to_reels"]!.map((x) => x)),
            awards: json["awards"] == null ? [] : List<dynamic>.from(json["awards"]!.map((x) => x)),
            education: json["education"],
            filmMakerProfile: json["film_maker_profile"],
            companyName: json["company_name"],
            companyEmail: json["company_email"],
            companyPhoneNumber: json["company_phone_number"],
            profilePicture: json["profile_picture"],
            endorsements: json["endorsements"],
            totalRatings: json["total_ratings"],
            averageRating: json["average_rating"],
            followers: json["followers"],
            following: json["following"],
            recentProjects: json["recent_projects"] == null ? [] : List<dynamic>.from(json["recent_projects"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
