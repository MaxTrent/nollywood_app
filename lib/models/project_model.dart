class ProjectModel {
  final bool error;
  final bool success;
  final ProjectDataModel? data;
  final int code;
  final String message;

  ProjectModel({
    required this.error,
    required this.success,
    this.data,
    required this.code,
    required this.message,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      error: json['error'] as bool,
      success: json['success'] as bool,
      data:
          json['data'] != null ? ProjectDataModel.fromJson(json['data']) : null,
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'success': success,
        'data': data?.toJson(),
        'code': code,
        'message': message,
      };
}

class ProjectDataModel {
  final String id;
  final String producerId;
  final String projectName;
  final String description;
  final String thumbnailUrl;
  final bool published;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectDataModel({
    required this.id,
    required this.producerId,
    required this.projectName,
    required this.description,
    required this.thumbnailUrl,
    required this.published,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectDataModel.fromJson(Map<String, dynamic> json) {
    return ProjectDataModel(
      id: json['_id'] as String,
      producerId: json['producer_id'] as String,
      projectName: json['project_name'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnail'] as String,
      published: json['published'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'producer_id': producerId,
        'project_name': projectName,
        'description': description,
        'thumbnail': thumbnailUrl,
        'published': published,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
