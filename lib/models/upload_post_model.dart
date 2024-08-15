class UploadPostResponse {
  final bool error;
  final bool success;
  final UploadPostData? data;  // Make data nullable
  final int code;
  final String message;

  UploadPostResponse({
    required this.error,
    required this.success,
    this.data,  // Accepting nullable data
    required this.code,
    required this.message,
  });

  factory UploadPostResponse.fromJson(Map<String, dynamic> json) {
    return UploadPostResponse(
      error: json['error'] as bool,
      success: json['success'] as bool,
      data: json['data'] != null ? UploadPostData.fromJson(json['data'] as Map<String, dynamic>) : null,
      code: json['code'] as int,
      message: json['message'] as String,
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

class UploadPostData {
  final String mediaUpload;

  UploadPostData({required this.mediaUpload});

  factory UploadPostData.fromJson(Map<String, dynamic> json) {
    return UploadPostData(
      mediaUpload: json['mediaUpload'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mediaUpload': mediaUpload,
    };
  }
}
