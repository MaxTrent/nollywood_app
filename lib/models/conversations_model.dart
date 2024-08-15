class ConversationsModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  ConversationsModel(
      {required this.error,
      required this.success,
      required this.data,
      required this.code,
      required this.message});

  factory ConversationsModel.fromJson(Map<String, dynamic> json) {
    return ConversationsModel(
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
  List<Results>? results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  Data(
      {this.results,
      required this.page,
      required this.limit,
      required this.totalPages,
      required this.totalResults});

  factory Data.fromJson(Map<String, dynamic> json) {
    var resultList = json['data'] as List<dynamic>?;
    List<Results> parsedList = [];
    if (resultList != null) {
      parsedList = resultList.map((x) => Results.fromJson(x)).toList();
    }


    return Data(
      results:
      parsedList.isNotEmpty ? parsedList : null,
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results?.map((v) => v.toJson()).toList(),
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }
}

class Results {
  String id;
  List<String> participants;
  String createdAt;
  String updatedAt;
  int v;
  String lastMessage;
  String lastMessageBy;
  String lastMessageSentAt;
  UserProfile userProfile;

  Results(
      {required this.id,
      required this.participants,
      required this.createdAt,
      required this.updatedAt,
      required this.v,
      required this.lastMessage,
      required this.lastMessageBy,
      required this.lastMessageSentAt,
      required this.userProfile});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['_id'],
      participants: List<String>.from(json['participants']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      v: json['__v'],
      lastMessage: json['last_message'],
      lastMessageBy: json['last_message_by'],
      lastMessageSentAt: json['last_message_sent_at'],
      userProfile: json['user_profile'] != null
          ? UserProfile.fromJson(json['user_profile'])
          : UserProfile(firstName: '', lastName: '', profilePicture: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'participants': participants,
      'created_at': createdAt,
      'updated_at': updatedAt,
      '__v': v,
      'last_message': lastMessage,
      'last_message_by': lastMessageBy,
      'last_message_sent_at': lastMessageSentAt,
      'user_profile': userProfile.toJson(),
    };
  }
}

class UserProfile {
  String firstName;
  String lastName;
  String profilePicture;

  UserProfile(
      {required this.firstName,
      required this.lastName,
      required this.profilePicture});

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
