class GetMultipleRoles {
    GetMultipleRoles({
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

    factory GetMultipleRoles.fromJson(Map<String, dynamic> json){ 
        return GetMultipleRoles(
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
        required this.category,
        required this.newRole,
        required this.criteriaSet,
        required this.monologueScriptSet,
        required this.id,
        required this.projectId,
        required this.roleName,
        required this.createdAt,
        required this.updatedAt,
        required this.actorLookalike,
        required this.avgRating,
        required this.castEnd,
        required this.castStart,
        required this.country,
        required this.distance,
        required this.endorsement,
        required this.gender,
        required this.height,
        required this.playableAge,
        required this.skinType,
    });

    final List<String> category;
    final bool? newRole;
    final bool? criteriaSet;
    final bool? monologueScriptSet;
    final String? id;
    final String? projectId;
    final String? roleName;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? actorLookalike;
    final int? avgRating;
    final DateTime? castEnd;
    final DateTime? castStart;
    final String? country;
    final int? distance;
    final String? endorsement;
    final String? gender;
    final String? height;
    final String? playableAge;
    final String? skinType;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            category: json["category"] == null ? [] : List<String>.from(json["category"]!.map((x) => x)),
            newRole: json["new_role"],
            criteriaSet: json["criteria_set"],
            monologueScriptSet: json["monologue_script_set"],
            id: json["_id"],
            projectId: json["project_id"],
            roleName: json["role_name"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            actorLookalike: json["actor_lookalike"],
            avgRating: json["avg_rating"],
            castEnd: DateTime.tryParse(json["cast_end"] ?? ""),
            castStart: DateTime.tryParse(json["cast_start"] ?? ""),
            country: json["country"],
            distance: json["distance"],
            endorsement: json["endorsement"],
            gender: json["gender"],
            height: json["height"],
            playableAge: json["playable_age"],
            skinType: json["skin_type"],
        );
    }

}



// class GetMultipleRoles {
//     GetMultipleRoles({
//         required this.error,
//         required this.success,
//         required this.data,
//         required this.code,
//         required this.message,
//     });

//     final bool? error;
//     final bool? success;
//     final List<Datum> data;
//     final int? code;
//     final String? message;

//     factory GetMultipleRoles.fromJson(Map<String, dynamic> json){ 
//         return GetMultipleRoles(
//             error: json["error"],
//             success: json["success"],
//             data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//             code: json["code"],
//             message: json["message"],
//         );
//     }

// }

// class Datum {
//     Datum({
//         required this.category,
//         required this.criteriaSet,
//         required this.id,
//         required this.projectId,
//         required this.roleName,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.castEnd,
//         required this.castStart,
//         required this.newRole,
//         required this.actorLookalike,
//         required this.avgRating,
//         required this.country,
//         required this.distance,
//         required this.endorsement,
//         required this.gender,
//         required this.height,
//         required this.playableAge,
//         required this.skinType,
//     });

//     final List<String> category;
//     final bool? criteriaSet;
//     final String? id;
//     final String? projectId;
//     final String? roleName;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final DateTime? castEnd;
//     final DateTime? castStart;
//     final bool? newRole;
//     final String? actorLookalike;
//     final int? avgRating;
//     final String? country;
//     final int? distance;
//     final String? endorsement;
//     final String? gender;
//     final String? height;
//     final String? playableAge;
//     final String? skinType;

//     factory Datum.fromJson(Map<String, dynamic> json){ 
//         return Datum(
//             category: json["category"] == null ? [] : List<String>.from(json["category"]!.map((x) => x)),
//             criteriaSet: json["criteria_set"],
//             id: json["_id"],
//             projectId: json["project_id"],
//             roleName: json["role_name"],
//             createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//             updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//             castEnd: DateTime.tryParse(json["cast_end"] ?? ""),
//             castStart: DateTime.tryParse(json["cast_start"] ?? ""),
//             newRole: json["new_role"],
//             actorLookalike: json["actor_lookalike"],
//             avgRating: json["avg_rating"],
//             country: json["country"],
//             distance: json["distance"],
//             endorsement: json["endorsement"],
//             gender: json["gender"],
//             height: json["height"],
//             playableAge: json["playable_age"],
//             skinType: json["skin_type"],
//         );
//     }

// }

