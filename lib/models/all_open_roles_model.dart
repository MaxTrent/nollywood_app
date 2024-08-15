class AllOpenRolesModel {
  final bool error;
  final bool success;
  final String message;
  final int code;
  final List<OpenRoleData>? data;

  AllOpenRolesModel({
    required this.error,
    required this.success,
    required this.message,
    required this.code,
    this.data,
  });

  factory AllOpenRolesModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List<dynamic>?;
    List<OpenRoleData> parsedList = [];
    if (dataList != null) {
      parsedList = dataList.map((x) => OpenRoleData.fromJson(x)).toList();
    }

    return AllOpenRolesModel(
      error: json['error'],
      success: json['success'],
      message: json['message'],
      code: json['code'],
      data: parsedList.isNotEmpty ? parsedList : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'success': success,
        'message': message,
        'code': code,
        'data': data?.map((x) => x.toJson()).toList(),
      };
}

class OpenRoleData {
  final String id;
  final String projectId;
  final String roleName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime castStart;
  final DateTime castEnd;
  final bool newRole;
  final String thumbnailUrl;
  final String projectName;
  final String producerName;
  final bool? criteriaSet;
  final String? actorLookalike;
  final int? avgRating;
  final List<String>? category;
  final String? country;
  final int? distance;
  final String? endorsement;
  final String? gender;
  final String? height;
  final String? playableAge;
  final String? skinType;

  OpenRoleData({
    required this.id,
    required this.projectId,
    required this.roleName,
    required this.createdAt,
    required this.updatedAt,
    required this.castStart,
    required this.castEnd,
    required this.newRole,
    required this.thumbnailUrl,
    required this.projectName,
    required this.producerName,
    this.criteriaSet,
    this.actorLookalike,
    this.avgRating,
    this.category,
    this.country,
    this.distance,
    this.endorsement,
    this.gender,
    this.height,
    this.playableAge,
    this.skinType,
  });

  factory OpenRoleData.fromJson(Map<String, dynamic> json) => OpenRoleData(
        id: json['_id'],
        projectId: json['project_id'],
        roleName: json['role_name'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        castStart: DateTime.parse(json['cast_start']),
        castEnd: DateTime.parse(json['cast_end']),
        newRole: json['new_role'],
    thumbnailUrl: json['thumbnail_url'],
        projectName: json['project_name'],
        producerName: json['producer_name'],
        criteriaSet: json['criteria_set'],
        actorLookalike: json['actor_lookalike'],
        avgRating: json['avg_rating'],
        category: json['category']?.cast<String>(),
        country: json['country'],
        distance: json['distance'],
        endorsement: json['endorsement'],
        gender: json['gender'],
        height: json['height'],
        playableAge: json['playable_age'],
        skinType: json['skin_type'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'project_id': projectId,
        'role_name': roleName,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'cast_start': castStart.toIso8601String(),
        'cast_end': castEnd.toIso8601String(),
        'new_role': newRole,
    'thumbnail_url': thumbnailUrl,
    'project_name': projectName,
    'producer_name': producerName,
        'criteria_set': criteriaSet,
        'actor_lookalike': actorLookalike,
        'avg_rating': avgRating,
        'category': category?.toList(),
        'country': country,
        'distance': distance,
        'endorsement': endorsement,
        'gender': gender,
        'height': height,
        'playable_age': playableAge,
        'skin_type': skinType,
      };
}
