class ApplicationProjectResponseModel {
  final bool error;
  final bool success;
  final String message;
  final int code;
  final ApplicationProjectModel data;

  ApplicationProjectResponseModel({
    required this.error,
    required this.success,
    required this.message,
    required this.code,
    required this.data,
  });

  factory ApplicationProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      ApplicationProjectResponseModel(
        error: json['error'],
        success: json['success'],
        message: json['message'],
        code: json['code'],
        data: ApplicationProjectModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'success': success,
        'message': message,
        'code': code,
        'data': data.toJson(),
      };
}

class ApplicationProjectModel {
  final String id;
  final String actorId;
  final String projectId;
  final String monologuePost;
  final String thumbnailUrl;
  final String projectName;
  final String producerName;
  final DateTime createdAt;
  final DateTime updatedAt;

  ApplicationProjectModel({
    required this.id,
    required this.actorId,
    required this.projectId,
    required this.monologuePost,
    required this.thumbnailUrl,
    required this.projectName,
    required this.producerName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApplicationProjectModel.fromJson(Map<String, dynamic> json) =>
      ApplicationProjectModel(
        id: json['_id'],
        actorId: json['actor_id'],
        projectId: json['project_id'],
        monologuePost: json['monologue_post'],
        thumbnailUrl: json['thumbnail_url'],
        projectName: json['project_name'],
        producerName: json['producer_name'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'actor_id': actorId,
        'project_id': projectId,
        'monologue_post': monologuePost,
        'thumbnail_url': thumbnailUrl,
        'project_name': projectName,
        'producer_name': producerName,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
