import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/data/api_services.dart';
import 'package:nitoons/models/project_model.dart';

class ProjectPageViewModel {
  final WidgetRef ref;
  ProjectPageViewModel(this.ref);

  static final getProjectProvider =
      FutureProvider.family<ProjectModel, String>((ref, projectId) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getProject(projectId);
  });
}
