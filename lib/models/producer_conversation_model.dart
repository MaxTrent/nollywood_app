class ProducerConversationsModel {
    ProducerConversationsModel({
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

    factory ProducerConversationsModel.fromJson(Map<String, dynamic> json){ 
        return ProducerConversationsModel(
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
        required this.results,
        required this.page,
        required this.limit,
        required this.totalPages,
        required this.totalResults,
    });

    final List<Result> results;
    final int? page;
    final int? limit;
    final int? totalPages;
    final int? totalResults;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
            page: json["page"],
            limit: json["limit"],
            totalPages: json["totalPages"],
            totalResults: json["totalResults"],
        );
    }

}

class Result {
    Result({
        required this.id,
        required this.participants,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.lastMessage,
        required this.lastMessageBy,
        required this.lastMessageSentAt,
        required this.userProfile,
    });

    final String? id;
    final List<String> participants;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? lastMessage;
    final String? lastMessageBy;
    final DateTime? lastMessageSentAt;
    final UserProfile? userProfile;

    factory Result.fromJson(Map<String, dynamic> json){ 
        return Result(
            id: json["_id"],
            participants: json["participants"] == null ? [] : List<String>.from(json["participants"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
            lastMessage: json["last_message"],
            lastMessageBy: json["last_message_by"],
            lastMessageSentAt: DateTime.tryParse(json["last_message_sent_at"] ?? ""),
            userProfile: json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]),
        );
    }

}

class UserProfile {
    UserProfile({
        required this.firstName,
        required this.lastName,
        required this.profilePicture,
    });

    final String? firstName;
    final String? lastName;
    final String? profilePicture;

    factory UserProfile.fromJson(Map<String, dynamic> json){ 
        return UserProfile(
            firstName: json["first_name"],
            lastName: json["last_name"],
            profilePicture: json["profile_picture"],
        );
    }

}
