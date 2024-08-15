class AllApplicationsResponseModel {
  final bool error;
  final bool success;
  final String message;
  final int code;
  final List<ApplicationData>? data;

  AllApplicationsResponseModel({
    required this.error,
    required this.success,
    required this.message,
    required this.code,
    this.data,
  });

  factory AllApplicationsResponseModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List<dynamic>?;
    List<ApplicationData> parsedList = [];
    if (dataList != null) {
      parsedList = dataList.map((x) => ApplicationData.fromJson(x)).toList();
    }

    return AllApplicationsResponseModel(
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
        'data': data!.map((x) => x.toJson()).toList(),
      };
}

class ApplicationData {
  final String id;
  final String? actorId;
  final String? projectId;
  final String? monologuePost;
  final String? thumbnailUrl;
  final String? projectName;
  final String? producerName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ApplicationData({
    required this.id,
    this.actorId,
    this.projectId,
    this.monologuePost,
    this.thumbnailUrl,
    this.projectName,
    this.producerName,
    this.createdAt,
    this.updatedAt,
  });

  factory ApplicationData.fromJson(Map<String, dynamic> json) => ApplicationData(
    id: json['_id'] ,
    actorId: json['actor_id'],
    projectId: json['project_id'],
    monologuePost: json['monologue_post'],
    thumbnailUrl: json['thumbnail_url'],
    projectName: json['project_name'],
    producerName: json['producer_name'],
    createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'actor_id': actorId,
    'project_id': projectId,
    'monologue_post': monologuePost,
    'thumbnail_url': thumbnailUrl,
    'project_name': projectName,
    'producer_name': producerName,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
