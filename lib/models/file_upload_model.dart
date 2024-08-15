class FileUploadModel {
  final bool error;
  final bool success;
  final String message;
  final int code;
  final FileUploadData data;

  FileUploadModel({
    required this.error,
    required this.success,
    required this.message,
    required this.code,
    required this.data,
  });

  factory FileUploadModel.fromJson(Map<String, dynamic> json) =>
      FileUploadModel(
        error: json['error'],
        success: json['success'],
        message: json['message'],
        code: json['code'],
        data: FileUploadData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'success': success,
        'message': message,
        'code': code,
        'data': data.toJson(),
      };
}

class FileUploadData {
  final String userId;
  final MediaUpload mediaUpload;
  final String description;
  final int likes;
  final int comments;
  final String visibility;
  final String id;
  final DateTime postedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileUploadData({
    required this.userId,
    required this.mediaUpload,
    required this.description,
    required this.likes,
    required this.comments,
    required this.visibility,
    required this.id,
    required this.postedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileUploadData.fromJson(Map<String, dynamic> json) => FileUploadData(
        userId: json['user_id'],
        mediaUpload: MediaUpload.fromJson(json['media_upload']),
        description: json['description'],
        likes: json['likes'],
        comments: json['comments'],
        visibility: json['visibility'],
        id: json['_id'],
        postedAt: DateTime.parse(json['posted_at']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'media_upload': mediaUpload.toJson(),
        'description': description,
        'likes': likes,
        'comments': comments,
        'visibility': visibility,
        '_id': id,
        'posted_at': postedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class MediaUpload {
  final String id;
  final String userId;
  final String resourceId;
  final String cloudProvider;
  final String mediaType;
  final String videoUrl;
  final double fileSize;
  final DateTime uploadedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  MediaUpload({
    required this.id,
    required this.userId,
    required this.resourceId,
    required this.cloudProvider,
    required this.mediaType,
    required this.videoUrl,
    required this.fileSize,
    required this.uploadedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MediaUpload.fromJson(Map<String, dynamic> json) => MediaUpload(
        id: json['_id'],
        userId: json['user_id'],
        resourceId: json['media_upload']['resource_id'],
        cloudProvider: json['media_upload']['cloud_provider'],
        mediaType: json['media_upload']['media_type'],
        videoUrl: json['media_upload']['video_url'],
        fileSize: json['media_upload']['file_size'],
        uploadedAt: DateTime.parse(json['media_upload']['uploaded_at']),
        createdAt: DateTime.parse(json['media_upload']['created_at']),
        updatedAt: DateTime.parse(json['media_upload']['updated_at']),
      );

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'media_upload': {
        'resource_id': resourceId,
        'cloud_provider': cloudProvider,
        'media_type': mediaType,
        'video_url': videoUrl,
        'file_size': fileSize,
        'uploaded_at': uploadedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      },
    };
  }
}
