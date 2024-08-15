class InvitationModel {
  final bool error;
  final bool success;
  final List<InvitationData>? data;
  final int code;
  final String message;

  InvitationModel({
    required this.error,
    required this.success,
    this.data,
    required this.code,
    required this.message,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      error: json['error'] as bool,
      success: json['success'] as bool,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => InvitationData.fromJson(e))
              .toList()
          : null,
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'success': success,
        'data': data?.map((e) => e.toJson()).toList(),
        'code': code,
        'message': message,
      };
}

class InvitationData {
  final String id;
  final String producerId;
  final String actorId;
  final String? projectId;
  final String? roleId;
  final String thumbnailUrl;
  final String congratsMessage;
  final String inviteMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? status;

  InvitationData({
    required this.id,
    required this.producerId,
    required this.actorId,
    this.projectId,
    this.roleId,
    required this.thumbnailUrl,
    required this.congratsMessage,
    required this.inviteMessage,
    required this.createdAt,
    required this.updatedAt,
    this.status,
  });

  factory InvitationData.fromJson(Map<String, dynamic> json) {
    return InvitationData(
      id: json['_id'] as String,
      producerId: json['producer_id'] as String,
      actorId: json['actor_id'] as String,
      projectId: json['project_id'] as String?,
      roleId: json['role_id'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String,
      congratsMessage: json['congrats_message'] as String,
      inviteMessage: json['invite_message'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'producer_id': producerId,
        'actor_id': actorId,
        'project_id': projectId,
        'role_id': roleId,
        'thumbnail_url': thumbnailUrl,
        'congrats_message': congratsMessage,
        'invite_message': inviteMessage,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'status': status,
      };
}
