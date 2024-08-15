class MonologueScriptModel {
  bool error;
  bool success;
  MonologueScriptData? data;
  int code;
  String message;

  MonologueScriptModel({
    required this.error,
    required this.success,
    this.data,
    required this.code,
    required this.message,
  });

  factory MonologueScriptModel.fromJson(Map<String, dynamic> json) {
    return MonologueScriptModel(
      error: json['error'],
      success: json['success'],
      data: json['data'] != null ? MonologueScriptData.fromJson(json['data']): null,
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'success': success,
      'data': data?.toJson(),
      'code': code,
      'message': message,
    };
  }
}

class MonologueScriptData {
  String id;
  String projectId;
  String script;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  MonologueScriptData({
    required this.id,
    required this.projectId,
    required this.script,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MonologueScriptData.fromJson(Map<String, dynamic> json) {
    return MonologueScriptData(
      id: json['_id'],
      projectId: json['project_id'],
      script: json['script'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'project_id': projectId,
      'script': script,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
