class ConversationMessageModel {
  final bool error;
  final bool success;
  final Data data;
  final int code;
  final String message;

  ConversationMessageModel({
    required this.error,
    required this.success,
    required this.data,
    required this.code,
    required this.message,
  });

  factory ConversationMessageModel.fromJson(Map<String, dynamic> json) {
    return ConversationMessageModel(
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
  final List<Results> results;
  final int page;
  final int limit;
  final int totalPages;
  final int totalResults;

  Data({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      results: List<Results>.from(
          json['results'].map((result) => Results.fromJson(result))),
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((result) => result.toJson()).toList(),
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }
}

class Results {
  final String id;
  final String sentBy;
  final String conversationId;
  final String messageType;
  final String message;
  final String sentAt;
  final List<String> readBy;
  final String createdAt;
  final String updatedAt;
  final UserProfile userProfile;

  Results({
    required this.id,
    required this.sentBy,
    required this.conversationId,
    required this.messageType,
    required this.message,
    required this.sentAt,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
    required this.userProfile,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['_id'],
      sentBy: json['sent_by'],
      conversationId: json['conversation_id'],
      messageType: json['message_type'],
      message: json['message'],
      sentAt: json['sent_at'],
      readBy: List<String>.from(json['read_by']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userProfile: UserProfile.fromJson(json['user_profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sent_by': sentBy,
      'conversation_id': conversationId,
      'message_type': messageType,
      'message': message,
      'sent_at': sentAt,
      'read_by': readBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_profile': userProfile.toJson(),
    };
  }
}

class UserProfile {
  final String firstName;
  final String lastName;
  final String profilePicture;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'profile_picture': profilePicture,
    };
  }
}
