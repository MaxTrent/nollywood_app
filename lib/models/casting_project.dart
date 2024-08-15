class CastingProject {
    CastingProject({
        required this.error,
        required this.success,
        required this.data,
        required this.code,
        required this.message,
    });

    final bool? error;
    final bool? success;
    final List<Datum> data;
    final int? code;
    final String? message;

    factory CastingProject.fromJson(Map<String, dynamic> json){ 
        return CastingProject(
            error: json["error"],
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            code: json["code"],
            message: json["message"],
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.producerId,
        required this.projectName,
        required this.description,
        required this.thumbnail,
        required this.monologueScriptSet,
        required this.newProject,
        required this.published,
        required this.createdAt,
        required this.updatedAt,
        required this.castEnd,
        required this.castStart,
    });

    final String? id;
    final String? producerId;
    final String? projectName;
    final String? description;
    final String? thumbnail;
    final bool? monologueScriptSet;
    final bool? newProject;
    final bool? published;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final DateTime? castEnd;
    final DateTime? castStart;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            producerId: json["producer_id"],
            projectName: json["project_name"],
            description: json["description"],
            thumbnail: json["thumbnail"],
            monologueScriptSet: json["monologue_script_set"],
            newProject: json["new_project"],
            published: json["published"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            castEnd: DateTime.tryParse(json["cast_end"] ?? ""),
            castStart: DateTime.tryParse(json["cast_start"] ?? ""),
        );
    }

}
