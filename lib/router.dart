import 'package:flutter/material.dart';
import 'package:nitoons/UI Actor/Congratulations/congratulation.dart';
import 'package:nitoons/UI%20Actor/Invitations/invitation.dart';
import 'package:nitoons/UI Actor/SignUp/sign_up.dart';

import 'package:nitoons/UI Actor/edit-profile/edit-profile_view.dart';
import 'package:nitoons/UI Actor/edit-profile/notifications-page.dart';
import 'package:nitoons/UI Actor/edit-profile/rate_and_review.dart';
import 'package:nitoons/UI Actor/friends_page/friends_page.dart';
import 'package:nitoons/UI Actor/group-icon_upload/new_group_icon_upload.dart';
import 'package:nitoons/UI Actor/headshots/headshots_view.dart';
import 'package:nitoons/UI Actor/login-phoneNumber/login_phonenumber_view.dart';
import 'package:nitoons/UI Actor/new-group/create-new-group.dart';

import 'package:nitoons/UI Actor/password setup/password_setup.dart';
import 'package:nitoons/UI Actor/phone number/phone_number.dart';
import 'package:nitoons/UI Actor/pin verification/pin_verification.dart';
import 'package:nitoons/UI Actor/preferred_roles/preferred_roles_view.dart';

import 'package:nitoons/UI Actor/role/background-actor.dart';
import 'package:nitoons/UI Actor/role/education-page.dart';
import 'package:nitoons/UI Actor/role/house-rules.dart';
import 'package:nitoons/UI Actor/role/page-three/age_page.dart';
import 'package:nitoons/UI Actor/role/page-two/name_page.dart';
import 'package:nitoons/UI%20Actor/project_done_section/project-done.dart';
import 'package:nitoons/UI Actor/role/sign_up_role_view.dart';
import 'package:nitoons/UI Actor/settings/settings_view.dart';
import 'package:nitoons/UI%20Actor/actor_lookalikes/actor_lookalikes.dart';
import 'package:nitoons/UI%20Actor/awards/awards.dart';
import 'package:nitoons/UI%20Actor/choose_monologue/choose_monologue.dart';
import 'package:nitoons/UI%20Actor/email_signup_opt/email_pin_verification.dart';
import 'package:nitoons/UI%20Actor/forgot_password_email/forgot_password_email.dart';
import 'package:nitoons/UI%20Actor/height/height.dart';
import 'package:nitoons/UI%20Actor/language/language.dart';
import 'package:nitoons/UI%20Actor/link_to_reels/link_to_reels.dart';
import 'package:nitoons/UI%20Actor/other_skills/other_skills.dart';
import 'package:nitoons/UI%20Producer/producer_create_profile/producer_companyinfo.dart';
import 'package:nitoons/UI%20Producer/producer_create_profile/producer_filmmaker_profile.dart';
import 'UI Actor/edit_actor_profile/edit_actor_profile.dart';
import 'UI Actor/email_address_signUp/email_address.dart';
import 'UI Actor/headshot/headshot_view.dart';
import 'UI Actor/headshot/headsideshot.dart';
import 'UI Actor/location/location_view.dart';
import 'UI Actor/password email setup/password_email_setup.dart';
import 'UI Actor/post/upload_post.dart';
import 'UI Actor/profile_picture/profile_picture_view.dart';
import 'UI Actor/record_monologue/record_monologue.dart';
import 'UI Producer/Applicants/applicants_view.dart';
import 'UI Producer/ProducerMessageSettings/producer_message_settings_view.dart';
import 'UI Producer/add_monologues_to_role/add_monologues_to_role.dart';
import 'UI Producer/add_monologues_to_role/add_monologues_to_role_update.dart';
import 'UI Producer/age_acct_update/age_update.dart';
import 'UI Producer/create_roles/create_roles.dart';
import 'UI Producer/edit_profile/age_edit_section/age_edit.dart';
import 'UI Producer/edit_profile/awards_edit_section/awards_edit.dart';
import 'UI Producer/edit_profile/company_info/company_info_edit.dart';
import 'UI Producer/edit_profile/company_location_edit.dart/company_location.dart';
import 'UI Producer/edit_profile/education_edit_section/education_edit.dart';
import 'UI Producer/edit_profile/filmmaker_profile_edit_section.dart/filmmaker_profile_edit.dart';
import 'UI Producer/edit_profile/gender_edit_section/gender_edit.dart';
import 'UI Producer/edit_profile/height_edit_section/height_edit.dart';
import 'UI Producer/edit_profile/language_edit_section/language_edit.dart';
import 'UI Producer/edit_profile/recent_project_section/recent_projects_edit.dart';
import 'UI Producer/gender_acct_update/gender_update.dart';
import 'UI Producer/producer casting applicant/producer_casting_applicants_view.dart';
import 'UI Producer/producer casting applicant/producer_casting_results_page_view.dart';
import 'UI Producer/producer casting applicant/producer_list_casting_applicants_view.dart';
import 'UI Producer/producer monologue/producer_create_monologue_view.dart';
import 'UI Producer/producer monologue/producer_current_role_view.dart';
import 'UI Producer/project_casting_period/producer_monologue_casting_time.dart';
import 'UI Producer/producer monologue/producer_monologue_project_details_view.dart';
import 'UI Producer/producer monologue/producer_monologue_roles_view.dart';
import 'UI Producer/producer Endorse rate and review/producer_endorse_rate_and_review.dart';
import 'UI Producer/producer rate and review page/producer_rate_review_view.dart';
import 'UI Producer/producerSettings/settings_view.dart';
import 'UI Producer/producer_create_profile/producer_company_location.dart';
import 'UI Producer/producer_create_profile/producer_name_page.dart';
import 'UI Producer/producer_create_profile/producer_upload_picture.dart';
import 'UI Producer/producer_nav_screens/producer_projects/producer_projects.dart';
import 'UI Producer/project/producer_project.view.dart';
import 'UI Producer/project/producer_project_Description_view.dart';
import 'UI Producer/project/producer_project_groupicon_view.dart';
import 'UI Actor/home_page.dart';
import 'UI Actor/login_email Address/login_email_address_view.dart';
import 'UI Actor/role/page-one/role-page.dart';
import 'UI Producer/project_details_roles/project_details_roles_view.dart';
import 'UI Producer/update_create_roles/create_roles_update.dart';
import 'UI Producer/update_producer_create_monologue/producer_update_create_monologue_view.dart';
import 'UI Producer/update_project_details/producer_project_update_Description_view.dart';
import 'UI Producer/update_project_details/producer_project_update_groupicon_view.dart';
import 'UI Producer/update_project_details/producer_project_update_name_view.dart';
import 'UI Producer/update_project_details/producer_project_update_overview_view.dart';

final Map<String, WidgetBuilder> routes = {
  SignUpPage.routeName: (context) => SignUpPage(),
  PhoneNumberPage.routeName: (context) => PhoneNumberPage(),
  PinVericationPage.routeName: (context) => PinVericationPage(),
  PasswordSetUpPage.routeName: (context) => PasswordSetUpPage(),
  LoginPhoneNumberPage.routeName: (context) => LoginPhoneNumberPage(),
  LoginEmailAddressPage.routeName: (context) => LoginEmailAddressPage(),
  RolePage.routeName: (context) => const RolePage(),
  NamePage.routeName: (context) => const NamePage(),
  SignUpRolePage.routeName: (context) => const SignUpRolePage(),
  AgePage.routeName: (context) => const AgePage(),
  HouseRulesPage.routeName: (context) => const HouseRulesPage(),
  CongratulationPage.routeName: (context) => CongratulationPage(),
  BackgroundActorPage.routeName: (context) => const BackgroundActorPage(),
  // ProjectDonePage.routeName: (context) => const ProjectDonePage(),
  EducationPage.routeName: (context) => const EducationPage(),
  HeadShotPage.routeName: (context) => const HeadShotPage(),
  EditActorProfile.routeName: (context) => const EditActorProfile(),
  ProfilePictureView.routeName: (context) => const ProfilePictureView(),
  
  // ProjectPage.routeName: (context) => const ProjectPage(),
  InvitationPage.routeName: (context) => InvitationPage(),
  NewGroupPage.routeName: (context) => NewGroupPage(),
  GroupIconUploadPage.routeName: (context) => GroupIconUploadPage(),
  FriendPage.routeName: (context) => FriendPage(),
  EditProfilePage.routeName: (context) => EditProfilePage(),
  NotificationsPage.routeName: (context) => NotificationsPage(),
  RateandReviewPage.routeName: (context) => RateandReviewPage(),
  SettingsPage.routeName: (context) => SettingsPage(),
  ActorUploadPost.routeName: (context) => ActorUploadPost(),
  ActorlookalikeScreen.routeName: (Context) => ActorlookalikeScreen(),
  OtherSkills.routeName: (context) => OtherSkills(),
  HeightScreen.routeName: (context) => HeightScreen(),
  LanguageScreen.routeName: (context) => LanguageScreen(),
  LinkToReels.routeName: (context) => LinkToReels(),
  Awards.routeName: (context) => Awards(),
  RecordMonologue.routeName: (context) => RecordMonologue(),
  ChooseMonologue.routeName: (context) => ChooseMonologue(),
  HeadshotView.routeName: (context) => HeadshotView(),
  //producer
  ProducerProjectPage.routeName: (context) => ProducerProjectPage(),

  ProducerProjectDescriptionPage.routeName: (context) =>
      ProducerProjectDescriptionPage(),
  ProducerProjectGroupIconUploadPage.routeName: (context) =>
      ProducerProjectGroupIconUploadPage(),
  ProducerEndorseRateandReviewPage.routeName: (context) =>
      ProducerEndorseRateandReviewPage(),
  ProducerMonologueRolesPage.routeName: (context) =>
      ProducerMonologueRolesPage(),
  ProducerCreateMonologueRolesPage.routeName: (context) =>
      ProducerCreateMonologueRolesPage(),
  ProducerMonologueProjectDetailsPage.routeName: (context) =>
      ProducerMonologueProjectDetailsPage(),
  ProducerMonologueCastingTime.routeName: (context) =>
      ProducerMonologueCastingTime(
        projectId: '',
        producerId: '',
      ),
  ProducerCurrentRolePage.routeName: (context) => ProducerCurrentRolePage(
        roleName: '',
        roleId: '',
      ),
  ProducerCastingApplicantsPage.routeName: (context) =>
      ProducerCastingApplicantsPage(),
  ProducerListCastingApplicantsPage.routeName: (context) =>
      ProducerListCastingApplicantsPage(),
  ProducerCastingResultsPage.routeName: (context) =>
      ProducerCastingResultsPage(),
  ProducerProjects.routeName: (context) => ProducerProjects(),
  ProducerHomePage.routeName: (context) => ProducerHomePage(),
  ProducerSettingsPage.routeName: (context) => ProducerSettingsPage(),
  ProducerMessageSettings.routeName: (context) => ProducerMessageSettings(),
  ProducerRateandReviewPage.routeName: (context) => ProducerRateandReviewPage(),
  ViewApplicantsPage.routeName: (context) => ViewApplicantsPage(),

  EmailAddressSignUp.routeName: (context) => EmailAddressSignUp(),
  EmailPasswordSetUpPage.routeName: (context) => EmailPasswordSetUpPage(),
  EmailPinVerificationPage.routeName: (context) =>
      EmailPinVerificationPage(emailAddress: ""),

  HomePage.routeName: (context) => HomePage(),
  PreferredRoles.routeName: (context) => PreferredRoles(),
  ForgotPasswordEmail.routeName: (context) => ForgotPasswordEmail(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  PhoneNumberPage.routeName: (context) => const PhoneNumberPage(),
  PinVericationPage.routeName: (context) => const PinVericationPage(),
  PasswordSetUpPage.routeName: (context) => const PasswordSetUpPage(),
  ProducerCompanyinfo.routeName: (context) => const ProducerCompanyinfo(),
  ProducerFilmmakerProfile.routeName: (context) =>
      const ProducerFilmmakerProfile(),
  ProducerNamePage.routeName: (context) => const ProducerNamePage(),
  ProducerUploadProfilePicture.routeName: (context) =>
      const ProducerUploadProfilePicture(),
  ProducerCompanyLocation.routeName: (context) =>
      const ProducerCompanyLocation(),
  CreateRoles.routeName: (context) => const CreateRoles(),
  ProducerAddMonologuesToRole.routeName: (context) =>
      ProducerAddMonologuesToRole(),
LocationView.routeName: (context) => LocationView(),
ActorlookalikeScreen.routeName: (context) => ActorlookalikeScreen(),

//edit profile
  AgeEdit.routeName: (context) => AgeEdit(),
  AwardsEdit.routeName: (context) => AwardsEdit(),
  CompanyInfoEdit.routeName: (context) => CompanyInfoEdit(),
  CompanyLocationEdit.routeName: (context) => CompanyLocationEdit(),
  EducationEdit.routeName: (context) => EducationEdit(),
  FilmmakerProfileEdit.routeName: (context) => FilmmakerProfileEdit(),
  GenderEdit.routeName: (context) => GenderEdit(),
  HeightEdit.routeName: (context) => HeightEdit(),
  LanguageEdit.routeName: (context) => LanguageEdit(),
  RecentProjectsEdit.routeName: (context) => RecentProjectsEdit(),

//update
  ProjectDonePage.routeName: (context) => ProjectDonePage(),
  GenderUpdate.routeName: (context) => GenderUpdate(),
  AgeUpdate.routeName: (context) => AgeUpdate(),

// update project
  ProducerProjectUpdateNameView.routeName: (context) =>
      ProducerProjectUpdateNameView(
        projectDescription: '',
        projectId: '',
        projectName: '',
      ),
  ProducerProjectUpdateDescriptionView.routeName: (context) =>
      ProducerProjectUpdateDescriptionView(),
  ProducerProjectUpdateGroupiconView.routeName: (context) =>
      ProducerProjectUpdateGroupiconView(),

  ProducerProjectUpdateOverviewView.routeName: (context) =>ProducerProjectUpdateOverviewView(),
  ProjectDetailsRolesView.routeName: (context) => ProjectDetailsRolesView(),
  ProducerAddMonologuesToRoleUpdate.routeName: (context) => ProducerAddMonologuesToRoleUpdate(),
  CreateRolesUpdate.routeName: (context) => CreateRolesUpdate(),
  ProducerUpdateCreateMonologueView.routeName: (context) =>  ProducerUpdateCreateMonologueView(),
Headsideshot.routeName: (context) =>  Headsideshot(),
};
