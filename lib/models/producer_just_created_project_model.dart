class PostCreatedProjectModel {
    PostCreatedProjectModel({
        required this.error,
        required this.success,
        required this.data,
        required this.code,
        required this.message,
    });

    final bool? error;
    final bool? success;
    final Data? data;
    final int? code;
    final String? message;

    factory PostCreatedProjectModel.fromJson(Map<String, dynamic> json){ 
        return PostCreatedProjectModel(
            error: json["error"],
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            code: json["code"],
            message: json["message"],
        );
    }

}

class Data {
    Data({
        required this.producerId,
        required this.projectName,
        required this.description,
        required this.thumbnail,
        required this.published,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? producerId;
    final String? projectName;
    final String? description;
    final String? thumbnail;
    final bool? published;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            producerId: json["producer_id"],
            projectName: json["project_name"],
            description: json["description"],
            thumbnail: json["thumbnail"],
            published: json["published"],
            id: json["_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
