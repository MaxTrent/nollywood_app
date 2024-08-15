class GetTimePostsModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  GetTimePostsModel({
    required this.error,
    required this.success,
    required this.data,
    required this.code,
    required this.message,
  });

  factory GetTimePostsModel.fromJson(Map<String, dynamic> json) =>
      GetTimePostsModel(
        error: json["error"] ?? false,
        success: json["success"] ?? false,
        data: Data.fromJson(json["data"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "success": success,
        "data": data.toJson(),
        "code": code,
        "message": message,
      };
}

class Data {
  List<Result> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  Data({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
        "totalResults": totalResults,
      };
}

class Result {
  String id;
  String userId;
  String? mediaUpload;
  String description;
  bool isLikedByYou;
  int likes;
  int comments;
  String visibility;
  DateTime postedAt;
  DateTime createdAt;
  DateTime updatedAt;
  UserProfile? userProfile;

  Result({
    required this.id,
    required this.userId,
    this.mediaUpload,
    required this.description,
    required this.isLikedByYou,
    required this.likes,
    required this.comments,
    required this.visibility,
    required this.postedAt,
    required this.createdAt,
    required this.updatedAt,
    this.userProfile,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        userId: json["user_id"],
        mediaUpload: json["media_upload"],
            // != null
            // ? MediaUpload.fromJson(json["media_upload"])
            // : null,
        description: json["description"],
        isLikedByYou: json["is_liked_by_you"],
        likes: json["likes"],
        comments: json["comments"],
        visibility: json["visibility"],
        postedAt: DateTime.parse(json["posted_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // userProfile: UserProfile.fromJson(json["user_profile"]),
        userProfile: json["user_profile"] != null
            ? UserProfile.fromJson(json["user_profile"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "media_upload": mediaUpload,
        // mediaUpload?.toJson(),
        "description": description,
    "is_liked_by_you": isLikedByYou,
        "likes": likes,
        "comments": comments,
        "visibility": visibility,
        "posted_at": postedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_profile": userProfile!.toJson(),
      };
}

class UserProfile {
  final String profilePicture;
  final String firstName;
  final String lastName;

  UserProfile({
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      profilePicture: json['profile_picture'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_picture': profilePicture,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}

class MediaUpload {
  String id;
  String userId;
  String resourceId;
  String cloudProvider;
  String mediaType;
  String videoUrl;
  double fileSize;
  DateTime uploadedAt;
  DateTime createdAt;
  DateTime updatedAt;

  MediaUpload({
    required this.id,
    required this.userId,
    required this.resourceId,
    required this.cloudProvider,
    required this.mediaType,
    required this.videoUrl,
    required this.fileSize,
    required this.uploadedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MediaUpload.fromJson(Map<String, dynamic> json) => MediaUpload(
        id: json["_id"],
        userId: json["user_id"],
        resourceId: json["resource_id"],
        cloudProvider: json["cloud_provider"],
        mediaType: json["media_type"],
        videoUrl: json["video_url"],
        fileSize: (json["file_size"] as num).toDouble(),
        uploadedAt: DateTime.parse(json["uploaded_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "resource_id": resourceId,
        "cloud_provider": cloudProvider,
        "media_type": mediaType,
        "video_url": videoUrl,
        "file_size": fileSize,
        "uploaded_at": uploadedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
