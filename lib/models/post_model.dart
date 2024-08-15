class PostsModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  PostsModel({
    required this.error,
    required this.success,
    required this.data,
    required this.code,
    required this.message,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
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
  String userId;
  MediaUpload mediaUpload;
  String description;
  int likes;
  int comments;
  String visibility;
  String id;
  String postedAt;
  String createdAt;
  String updatedAt;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['user_id'],
      mediaUpload: MediaUpload.fromJson(json['media_upload']),
      description: json['description'],
      likes: json['likes'],
      comments: json['comments'],
      visibility: json['visibility'],
      id: json['_id'],
      postedAt: json['posted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'media_upload': mediaUpload.toJson(),
      'description': description,
      'likes': likes,
      'comments': comments,
      'visibility': visibility,
      '_id': id,
      'posted_at': postedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class MediaUpload {
  String id;
  String userId;
  String resourceId;
  String cloudProvider;
  String mediaType;
  String videoUrl;
  double fileSize;
  String uploadedAt;
  String createdAt;
  String updatedAt;

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

  factory MediaUpload.fromJson(Map<String, dynamic> json) {
    return MediaUpload(
      id: json['_id'],
      userId: json['user_id'],
      resourceId: json['resource_id'],
      cloudProvider: json['cloud_provider'],
      mediaType: json['media_type'],
      videoUrl: json['video_url'],
      fileSize: json['file_size'].toDouble(),
      uploadedAt: json['uploaded_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'resource_id': resourceId,
      'cloud_provider': cloudProvider,
      'media_type': mediaType,
      'video_url': videoUrl,
      'file_size': fileSize,
      'uploaded_at': uploadedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
