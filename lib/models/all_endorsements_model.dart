class AllEndorsementsModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  AllEndorsementsModel(
      {required this.error,
      required this.success,
      required this.data,
      required this.code,
      required this.message});

  factory AllEndorsementsModel.fromJson(Map<String, dynamic> json) {
    return AllEndorsementsModel(
      error: json['error'],
      success: json['success'],
      data: Data.fromJson(json['data']),
      code: json['code'],
      message: json['message'],
    );
  }
}

class Data {
  List<Result> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  Data(
      {required this.results,
      required this.page,
      required this.limit,
      required this.totalPages,
      required this.totalResults});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      results:
          (json['results'] as List).map((i) => Result.fromJson(i)).toList(),
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
    );
  }
}

class Result {
  String id;
  String userId;
  String endorsedUser;
  String comment;
  int rating;
  String createdAt;
  String updatedAt;

  Result(
      {required this.id,
      required this.userId,
      required this.endorsedUser,
      required this.comment,
      required this.rating,
      required this.createdAt,
      required this.updatedAt});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['_id'],
      userId: json['user_id'],
      endorsedUser: json['endorsed_user'],
      comment: json['comment'],
      rating: json['rating'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
