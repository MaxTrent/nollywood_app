class ApiUrls {
  static const baseUrl = 'nitoons-actors-app-a18cc438c3bf.herokuapp.com';

  //static const baseUrl = 'sincere-jawfish-new.ngrok-free.app';

  // static const baseUrl = 'sincere-jawfish-new.ngrok-free.app';
  static const serverUrl =
      'https://nitoons-actors-app-a18cc438c3bf.herokuapp.com';
  // static const serverUrl = 'https://sincere-jawfish-new.ngrok-free.app';

  static const testBaseUrl = 'localhost:8069';

  static getMonologueScriptProjectId(String projectId) => '/v1/api/project-flow/monologue-script/project/get/$projectId';

  static const createNewApplicationProjectId =
      '/v1/api/project-flow/application/project/create';
  static const createNewApplicationRoleId =
      '/v1/api/project-flow/application/role/create';

  static getAllApplicationsActorId(String actorId) =>
      '/v1/api/project-flow/application/actor/get/all/$actorId';

  static getAllApplicationsProjectId(String projectId) =>
      'v1/api/project-flow/application/project/get/all/$projectId';

  static getAllApplicationsRoleId(String roleId) =>
      '/v1/api/project-flow/application/actor/get/all/$roleId';

  static getUserConversationMessages(String conversationId) =>
      '/v1/api/messaging/conversations/$conversationId/messages';

  static getProject(String projectId) =>
      '/v1/api/project-flow/project/get/$projectId';

  static getAllComments(String postId) =>
      '/v1/api/actions/engagements/comment/get/all/$postId';
  static getAllInvitations(String? actorId) =>
      '/v1/api/project-flow/invitation/get/all/$actorId';
  static likePost(String postId) => '/v1/api/actions/engagements/posts/$postId/like';
static unlikePost(String postId) => '/v1/api/actions/engagements/posts/$postId/unlike';
  static const makeComment = '/v1/api/actions/engagements/comment/post';
  static const replyComment = '/v1/api/actions/engagements/comment/reply';
  static const likeComment = '/v1/api/actions/engagements/comment/like';
  static const unlikeComment = '/v1/api/actions/engagements/comment/unlike';
  static const likeReply = '/v1/api/actions/engagements/comments/reply/like';
  static const unlikeReply = '/v1/api/actions/engagements/comment/unlike/reply';
  static const getAllOpenRoles = '/v1/api/project-flow/role/get/open/all';
  static const sendMessage = '/v1/api/messaging/send-message';
  static const getUserConversations = '/v1/api/messaging/conversations';
  static const initiateSignUpEmail =
      '/v1/api/users/onboarding/signup/email/initiate';
  static const finalizeSignUpEmail =
      '/v1/api/users/onboarding/signup/email/finalize';
  static const initiateSignUpPhone =
      '/v1/api/users/onboarding/signup/phone/initiate';
  static const validateSignUpOtpPhone =
      '/v1/api/users/onboarding/signup/phone/validate-otp';
  static const finalizeSignUpPhone =
      '/v1/api/users/onboarding/signup/phone/finalize';
  static const validateSignUpOtpEmail =
      '/v1/api/users/onboarding/signup/email/validate-otp';
  static const loginEmail = '/v1/api/users/onboarding/login/email/initiate';
  static const loginPhone = '/v1/api/users/onboarding/login/phone/initiate';
  static const logout = '/v1/api/auth/logout';
  static const refreshToken = '/v1/api/auth/refresh';
  static const requestPasswordResetEmail =
      '/v1/api/auth/request-password-reset/email';
  static const validatePasswordResetOtpEmail =
      '/v1/api/auth/request-password-reset/email/validate-otp';

  static const resetPasswordEmail = '/v1/api/auth/reset-password/email';
  static const requestPasswordResetPhone = '/v1/api/auth/reset-password/email';
  static const validatePasswordResetOtpPhone =
      '/v1/api/auth/request-password-reset/phone/validate-otp';
  static const resetPasswordPhone = '/v1/api/auth/reset-password/phone';
  static const createUserActorProfile =
      '/v1/api/onboard/user-profile/profile/create/actor';
  static const createUserProducerProfile =
      '/v1/api/onboard/user-profile/profile/create/producer';

  static const updateUserProfile =
      '/v1/api/onboard/user-profile/profile/update';
  static const updateUserImages =
      '/v1/api/onboard/user-profile/upload-actor-images';
  static const getUserProfile = '/v1/api/onboard/user-profile/profile/get/';
  static const completeAccountSetup =
      '/v1/api/onboard/user-profile/profile/return';

  static const createEndorsements =
      '/v1/api/actions/engagements/endorsement/initiate';
  static const getAllEndorsements =
      '/v1/api/actions/engagements/endorsement/get-all';
  static const followUser = '/v1/api/actions/engagements/follow';
  static const unfollowUser = '/v1/api/actions/engagements/unfollow';
  static const getTimelinePosts = "/v1/api/timeline/posts";
  static const createPosts = '/v1/api/actions/engagements/posts';
  static const uploadMedia = '/v1/api/actions/engagements/posts/upload-media';
  static const createProducerProfile =
      '/v1/api/onboard/user-profile/profile/create/producer';
  static const createProducerProject = '/v1/api/project-flow/project/create';
  static const getAllProducerProject = '/v1/api/project-flow/project/get/all/';
  static const getAllProducerCastingProject = '/v1/api/project-flow/project/get/casting/all';
  static const getProducerProject = '/v1/api/project-flow/project/get/';
  static const createRoles = '/v1/api/project-flow/role/create';
  static const updateCreatedRoles = '/v1/api/project-flow/role/update';

  static const createSingleMonologueScript =
      '/v1/api/project-flow/monologue-script/project/create';
  static const createMultipleMonologueScript =
      '/v1/api/project-flow/monologue-script/role/create';
  static const publishProject = '/v1/api/project-flow/project/publish';
  static const getAllProjectRoles = '/v1/api/project-flow/role/get/all/';
  static const updateProjectDetails = '/v1/api/project-flow/project/update';
  static const logOut = '/v1/api/auth/logout';
}
